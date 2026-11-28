"""Temperature field behind the Earth-processes figure.

The cold side follows the "slab" initial state of the annulus subduction models
(kaiju annulus_faults.py, slab_temperature, cold-top variant), reimplemented
here without Underworld:
  * surface plates cool as a half space, T = T_i erf(depth / 2 sqrt(age)), the
    plate age ramping from zero at the ridge to the trench age on the
    subducting side; on the overriding side an oceanic plate near the trench,
    then an older continent with a still older cratonic keel;
  * the slab cools from the same age continued down the fault plane, which
    leaves the trench at a fixed dip: T = T_i - T_i erfc(n / 2 sqrt(age)) into
    the subducting side (n the distance from the plane), a short cooled halo on
    the wedge side, the ends fading over their diffusion length;
  * T is the colder of the plate and the slab values.
Lengths are in units of the mantle depth d (2900 km), ages in d^2 (a plate of
age a is about 2 sqrt(a) thick: 0.0025 is 0.1 d, so the lithosphere is shown
about 2.5 times too thick, as in the models).
The hot side is added for this figure: a basal boundary layer (D'') and one
plume rising from it to a head beneath the oceanic plate.

Writes earth-processes-field-light.png, earth-processes-field-dark.png (RGBA,
transparent outside the mantle) and earth-processes.json (contours in mm, the
figure's own coordinates: centre at the origin, surface radius 64 mm).
"""
import json
import numpy as np
from scipy.special import erf, erfc
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.colors import LinearSegmentedColormap

R_MM = 64.0                     # surface radius on the page
D_KM = 2900.0
r_o = 6370.0 / D_KM             # 2.197
r_c = 3480.0 / D_KM             # 1.200
TH_L, TH_R = 145.0, 35.0        # wedge edges (degrees)
TH_T = 80.0                     # trench

T_i = 0.75                      # interior temperature (K1 default)
AGE_SUB = 0.0025                # subducting plate at the trench (K1 default)
AGE_OVER = 0.0010               # oceanic part of the overriding plate
AGE_CONT = 0.0016               # continental lithosphere
AGE_CRATON = 0.0045             # cratonic keel
CONT_EDGE = 66.0                # continental margin (degrees); continent from here to the wedge edge
CRATON = (56.0, 43.0)           # craton extent (degrees)
CRUST_KM = 120.0                # continental crust as drawn (about 2.5 times too thick, like the plates)
EDGE = 2.0                      # width of the transitions (degrees)
DIP = 60.0                      # slab dip (degrees)
SLAB_LEN = 0.55                 # down-dip length, d
WEDGE_AGE = 6.25e-4             # cooled halo on the wedge side (K1 default)
AGE_BASE = 9.0e-4               # basal hot layer
PLUME_TH, HEAD_TH = 124.0, 124.0
PLUME_DT = 0.22


def temperature(r, th):
    """r in d, th in degrees (arrays)."""
    depth = np.maximum(r_o - r, 0.0)
    # surface plates
    rel = np.radians(th - TH_T)                             # > 0 on the subducting (left) side
    ridge = np.radians(TH_L - TH_T)
    age_sub = AGE_SUB * np.clip(1 - rel / ridge, 0, 1)      # zero at the ridge, AGE_SUB at the trench
    in_cont = 0.5 * (1 + np.tanh((CONT_EDGE - th) / EDGE))
    in_craton = 0.5 * (np.tanh((th - CRATON[1]) / EDGE) + np.tanh((CRATON[0] - th) / EDGE))
    age_over = AGE_OVER + (AGE_CONT - AGE_OVER) * in_cont + (AGE_CRATON - AGE_CONT) * np.clip(in_craton, 0, 1)
    age = np.where(rel >= 0, age_sub, age_over)
    age = np.maximum(age, 2.0e-5)
    T_plate = T_i * erf(depth / (2 * np.sqrt(age)))
    # slab: plane from the trench, dipping toward the overriding (right, -theta) side
    t0 = np.radians(TH_T)
    r_hat = np.array([np.cos(t0), np.sin(t0)])
    u = -np.array([-np.sin(t0), np.cos(t0)])                # toward the overriding side
    phi = np.radians(DIP)
    down = np.cos(phi) * u - np.sin(phi) * r_hat
    n_sub = -(np.sin(phi) * u + np.cos(phi) * r_hat)        # into the subducting side
    x = r * np.cos(np.radians(th)) - r_o * r_hat[0]
    y = r * np.sin(np.radians(th)) - r_o * r_hat[1]
    s_raw = x * down[0] + y * down[1]
    n_into = x * n_sub[0] + y * n_sub[1]
    overshoot = np.maximum(s_raw - SLAB_LEN, 0.0) + np.maximum(-s_raw, 0.0)
    end = erfc(overshoot / (2 * np.sqrt(AGE_SUB)))
    scale = np.where(n_into >= 0, 2 * np.sqrt(AGE_SUB), 2 * np.sqrt(WEDGE_AGE))
    T_slab = T_i - T_i * end * erfc(np.abs(n_into) / scale)
    T_cold = np.minimum(T_plate, T_slab)
    # hot side: basal layer and a plume (scaled by T_cold / T_i so plates stay cold)
    hot = (1 - T_i) * erfc(np.maximum(r - r_c, 0) / (2 * np.sqrt(AGE_BASE)))
    arc_tail = np.radians(th - PLUME_TH) * r
    tail = np.exp(-(arc_tail / 0.035) ** 2) * (r < r_o - 0.2)        # the tail ends inside the head
    arc_head = np.radians(th - HEAD_TH) * r
    head = np.exp(-(arc_head / 0.30) ** 2 - ((r - (r_o - 0.2)) / 0.07) ** 2)
    hot = np.maximum(hot, PLUME_DT * np.maximum(tail, head))
    return T_cold + hot * (T_cold / T_i)


# ---- raster over the wedge's bounding box ----------------------------------------
xm = R_MM * np.cos(np.radians(TH_R))
NX, NY = 1400, int(1400 * R_MM / (2 * xm))
X, Y = np.meshgrid(np.linspace(-xm, xm, NX), np.linspace(R_MM, 0, NY))
Rmm = np.hypot(X, Y)
TH = np.degrees(np.arctan2(Y, X))
r = Rmm / R_MM * r_o
inside = (Rmm <= R_MM) & (r >= r_c) & (TH >= TH_R) & (TH <= TH_L)
T = np.where(inside, temperature(np.where(inside, r, r_o), TH), np.nan)

light = LinearSegmentedColormap.from_list("primer-T-light", [
    (0.00, "#5c87b8"), (0.40, "#b9cde3"), (0.75, "#f3f0ea"), (0.88, "#f0cfc0"), (1.00, "#d9876b")])
dark = LinearSegmentedColormap.from_list("primer-T-dark", [
    (0.00, "#d7e6f5"), (0.40, "#8fb0cf"), (0.75, "#2d5277"), (0.88, "#7a6688"), (1.00, "#e3a0b6")])
for name, cmap, alpha in (("light", light, 0.85), ("dark", dark, 0.9)):
    rgba = cmap(np.nan_to_num(T, nan=T_i) / 1.0)
    rgba[..., 3] = np.where(inside, alpha, 0.0)
    plt.imsave(f"earth-processes-field-{name}.png", rgba)

# ---- contours, in mm --------------------------------------------------------------
fig, ax = plt.subplots()
cs = ax.contour(X, Y, np.where(inside, T, T_i), levels=[0.9 * T_i, T_i + 0.06])
plt.close(fig)


def paths(level_index, min_len=12):
    out = []
    for seg in cs.allsegs[level_index]:
        if len(seg) >= min_len:
            out.append([[round(float(a), 3), round(float(b), 3)] for a, b in seg[:: max(1, len(seg) // 300)]])
    return out


# continental crust: a band of thickness CRUST_KM under the continent, tapering at the margin
ths = np.linspace(CONT_EDGE + 3 * EDGE, TH_R, 160)
thick = CRUST_KM * 0.5 * (1 + np.tanh((CONT_EDGE - ths) / EDGE))
to_mm = R_MM / 6370.0
outer = [[R_MM * np.cos(np.radians(t)), R_MM * np.sin(np.radians(t))] for t in ths]
inner = [[(6370.0 - h) * to_mm * np.cos(np.radians(t)), (6370.0 - h) * to_mm * np.sin(np.radians(t))]
         for t, h in zip(ths[::-1], thick[::-1])]
crust = [[round(a, 3), round(b, 3)] for a, b in outer + inner]
crust_base = [[round(a, 3), round(b, 3)] for a, b in inner[::-1]]

with open("earth-processes.json", "w") as f:
    json.dump({"extent": [-xm, 0, xm, R_MM], "cold": paths(0), "hot": paths(1),
               "r_cmb_mm": r_c / r_o * R_MM, "crust": crust, "crust_base": crust_base}, f)
print("cold contours", len(paths(0)), "hot contours", len(paths(1)))
