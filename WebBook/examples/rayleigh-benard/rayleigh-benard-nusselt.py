# ---
# jupyter:
#   jupytext:
#     formats: ipynb,py:percent
#     text_representation:
#       extension: .py
#       format_name: percent
#       format_version: '1.3'
#       jupytext_version: 1.19.7
#   kernelspec:
#     display_name: Python 3
#     language: python
#     name: python3
# ---

# %% [markdown]
# # Rayleigh–Bénard convection: how heat flow scales with the Rayleigh number
#
# Boundary-layer theory predicts that once convection is vigorous, the heat it
# carries grows as $Nu \sim Ra^{1/3}$ (see the chapter *Rayleigh–Bénard
# convection* in the Computational Geodynamics Primer). This notebook tests
# that prediction with Underworld3: it runs a square cell of fluid, heated from
# below and cooled from above, to steady state at several Rayleigh numbers,
# measures the Nusselt number $Nu$ each time, and fits the exponent.
#
# The set-up is the steady benchmark of Blankenbach et al. (1989): a unit
# square, free-slip walls, $T = 1$ at the base and $T = 0$ at the top,
# insulated sides, constant viscosity. Their reference values give a check on
# the numbers.
#
# The whole notebook takes about 15 minutes at the default resolution
# (longer on a busy Binder server). To go faster, run fewer Rayleigh numbers.

# %%
import nest_asyncio
nest_asyncio.apply()

import numpy as np
import sympy
import matplotlib.pyplot as plt
import underworld3 as uw

trapezoid = getattr(np, "trapezoid", None) or np.trapz   # numpy < 2 has only trapz

# %% [markdown]
# ## Parameters
#
# Change these and re-run. Finer cells (smaller `cell_size`) and higher
# Rayleigh numbers both take longer; $Ra = 10^6$ needs `cell_size` of about
# $1/32$ and several minutes.

# %%
rayleigh_numbers = [1.0e4, 3.0e4, 1.0e5]
cell_size = 1.0 / 16.0          # mesh cell size, in units of the layer depth
dt_factor = 2.0                 # time step as a multiple of the advective (CFL) estimate;
                                # halved automatically for Ra >= 5e4, where 2 is unstable
max_steps = 600                 # time steps allowed per run
tolerance = 1.0e-3              # steady when three checks, 10 steps apart, agree to this (relative)

# Blankenbach et al. (1989), case 1a-1b: Nu and v_rms
blankenbach = {1.0e4: (4.8844, 42.865), 1.0e5: (10.534, 193.21)}

# %% [markdown]
# ## The model
#
# One model is built and reused. Each Rayleigh number starts from the steady
# state of the previous one (*continuation*), which is much quicker than
# starting each run from rest.
#
# - **Stokes flow** with constant viscosity, driven by the buoyancy force
#   $Ra\,T$ in the vertical direction.
# - **Advection–diffusion** of temperature with Underworld's semi-Lagrangian
#   Crank–Nicolson solver.
# - The **Nusselt number** is the heat flux through the top, $-\partial T/\partial z$
#   averaged over the surface, divided by the conductive flux (which is 1 here).

# %%
mesh = uw.meshing.UnstructuredSimplexBox(
    minCoords=(0.0, 0.0), maxCoords=(1.0, 1.0), cellSize=cell_size, regular=False, qdegree=3,
)
x, z = mesh.X
v = uw.discretisation.MeshVariable("U", mesh, mesh.dim, degree=2)
p = uw.discretisation.MeshVariable("P", mesh, 1, degree=1)
T = uw.discretisation.MeshVariable("T", mesh, 1, degree=3)

stokes = uw.systems.Stokes(mesh, velocityField=v, pressureField=p)
stokes.constitutive_model = uw.constitutive_models.ViscousFlowModel
stokes.constitutive_model.Parameters.shear_viscosity_0 = 1.0
stokes.tolerance = 1.0e-3
# free slip on every wall
stokes.add_dirichlet_bc((sympy.oo, 0.0), "Bottom")
stokes.add_dirichlet_bc((sympy.oo, 0.0), "Top")
stokes.add_dirichlet_bc((0.0, sympy.oo), "Left")
stokes.add_dirichlet_bc((0.0, sympy.oo), "Right")

heat = uw.systems.AdvDiffusionSLCN(mesh, u_Field=T, V_fn=v)
heat.constitutive_model = uw.constitutive_models.DiffusionModel
heat.constitutive_model.Parameters.diffusivity = 1.0
heat.theta = 0.5
heat.add_dirichlet_bc(1.0, "Bottom")
heat.add_dirichlet_bc(0.0, "Top")

# start from conduction plus a single-cell perturbation
T0 = (1.0 - z) + 0.05 * sympy.cos(sympy.pi * x) * sympy.sin(sympy.pi * z)
T.array[...] = np.asarray(uw.function.evaluate(T0, T.coords)).reshape(T.array.shape)

# where the surface heat flux and the velocity are measured
xs = np.linspace(0.0, 1.0, 201)
top = np.column_stack([xs, np.full_like(xs, 1.0 - 1.0e-6)])
dTdz = mesh.vector.gradient(T.sym)[1]
gx, gz = np.meshgrid(np.linspace(0.0, 1.0, 41), np.linspace(0.0, 1.0, 41))
interior = np.column_stack([gx.ravel(), gz.ravel()])
px, pz = np.meshgrid(np.linspace(0, 1, 101), np.linspace(0, 1, 101))
plot_points = np.column_stack([px.ravel(), pz.ravel()])


def nusselt():
    flux = -np.asarray(uw.function.evaluate(dTdz, top)).reshape(-1)
    return trapezoid(flux, xs)


def vrms():
    vel = np.asarray(uw.function.evaluate(v.sym, interior)).reshape(-1, 2)
    return np.sqrt(np.mean(np.sum(vel ** 2, axis=1)))


def run_to_steady(Ra, max_steps=max_steps, tolerance=tolerance, verbose=True):
    """Set the Rayleigh number, step until Nu stops changing, return the measurements."""
    stokes.bodyforce = sympy.Matrix([0, Ra * T.sym[0]])
    stokes.solve(zero_init_guess=False)
    history = []
    for step in range(max_steps):
        dt = (dt_factor if Ra < 5.0e4 else 0.5 * dt_factor) * stokes.estimate_dt()
        heat.solve(timestep=dt, zero_init_guess=False)
        stokes.solve(zero_init_guess=False)
        if step % 10 == 0:
            history.append(nusselt())
            if verbose:
                print(f"  Ra = {Ra:.0e}  step {step:4d}  Nu = {history[-1]:.4f}")
            # steady: three successive checks agree (one small change can be a turning
            # point of the slowly decaying start-up oscillation)
            last = history[-3:]
            if len(last) == 3 and max(last) - min(last) < tolerance * abs(last[-1]):
                break
    Tgrid = np.asarray(uw.function.evaluate(T.sym, plot_points)).reshape(px.shape)
    return {"Ra": Ra, "Nu": history[-1], "vrms": vrms(), "steps": step + 1, "T": Tgrid}


# %% [markdown]
# ## Run the cells

# %%
results = [run_to_steady(Ra) for Ra in rayleigh_numbers]

print(f"\n{'Ra':>8} {'Nu':>8} {'v_rms':>8}   {'Nu (B89)':>9} {'v_rms (B89)':>11}")
for r in results:
    ref = blankenbach.get(r["Ra"])
    refs = f"{ref[0]:9.3f} {ref[1]:11.2f}" if ref else f"{'':>9} {'':>11}"
    print(f"{r['Ra']:8.0e} {r['Nu']:8.3f} {r['vrms']:8.2f}   {refs}")

# %% [markdown]
# ## Does $Nu$ scale as $Ra^{1/3}$?
#
# Fit a straight line to $\log Nu$ against $\log Ra$. Boundary-layer theory
# predicts a slope of $1/3$; the measured slope at these moderate Rayleigh
# numbers is close to it.

# %%
Ra = np.array([r["Ra"] for r in results])
Nu = np.array([r["Nu"] for r in results])
slope, intercept = np.polyfit(np.log(Ra), np.log(Nu), 1)
print(f"fitted exponent: {slope:.3f}   (boundary-layer theory: 1/3 = 0.333)")

fig, ax = plt.subplots(figsize=(5, 4))
ax.loglog(Ra, Nu, "o", color="#1f2a33", label="Underworld3")
ref_Ra = np.array(sorted(blankenbach))
ax.loglog(ref_Ra, [blankenbach[k][0] for k in ref_Ra], "s", mfc="none", color="#1b6f6a", label="Blankenbach et al. (1989)")
line = np.logspace(np.log10(Ra.min()) - 0.2, np.log10(Ra.max()) + 0.2, 20)
ax.loglog(line, np.exp(intercept) * line ** slope, "-", color="#9aa3aa", lw=1, label=f"fit, slope {slope:.2f}")
ax.loglog(line, Nu[0] * (line / Ra[0]) ** (1 / 3), "--", color="#9aa3aa", lw=1, label="slope 1/3")
ax.set_xlabel("Rayleigh number, $Ra$")
ax.set_ylabel("Nusselt number, $Nu$")
ax.legend(frameon=False, fontsize=8)
plt.tight_layout()
plt.show()

# %% [markdown]
# ## The boundary layers
#
# The temperature fields show why. As $Ra$ rises the interior becomes more
# nearly isothermal and the temperature drop is confined to thinner boundary
# layers at the top and bottom, and to the plumes rising and sinking at the
# sides. A thinner boundary layer carries more heat by conduction, which is
# where the extra $Nu$ comes from.

# %%
fig, axes = plt.subplots(1, len(results), figsize=(3.2 * len(results), 3.2))
for ax, r in zip(np.atleast_1d(axes), results):
    ax.imshow(r["T"], origin="lower", extent=(0, 1, 0, 1), cmap="RdBu_r", vmin=0, vmax=1)
    ax.contour(np.linspace(0, 1, 101), np.linspace(0, 1, 101), r["T"], levels=np.linspace(0.1, 0.9, 9),
               colors="k", linewidths=0.4)
    ax.set_title(f"$Ra = {r['Ra']:.0e}$, $Nu = {r['Nu']:.2f}$", fontsize=9)
    ax.set_xticks([]); ax.set_yticks([])
plt.tight_layout()
plt.show()

# %% [markdown]
# ## Things to try
#
# 1. Reduce `cell_size` to $1/24$ and re-run. How much do the Nusselt numbers
#    change, and are they closer to the Blankenbach values?
# 2. Add $Ra = 10^6$ (with `cell_size = 1/32`). Does the exponent stay near
#    $1/3$?
# 3. Make the cell twice as wide (`maxCoords=(2.0, 1.0)` when the mesh is
#    built). How many cells form, and how does $Nu$ change?
