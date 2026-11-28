(sec-solutions)=
# Solutions to Selected Problems

Worked solutions to the exercises marked {sup}`★` in each chapter, in the order
the chapters appear in the book. Try the exercise before reading the solution.

(sol-navier-stokes)=
## Navier-Stokes Equation

Exercises: [](#sec-navier-stokes-exercises).

### Exercise 1: Material Derivative

The material derivative is:
$$
\frac{D\mathbf{f}}{Dt} = \frac{\partial \mathbf{f}}{\partial t} + (\uv \cdot \GRAD)\mathbf{f}
$$

For the advective term to equal the total derivative, we need:
$$
\frac{\partial \mathbf{f}}{\partial t} = 0
$$

**Physical meaning**: This occurs when the flow is **steady** (time-independent at fixed points in space). In steady flow, all changes experienced by a fluid parcel are due to its motion through spatially varying fields, not due to temporal changes at fixed locations.

### Exercise 2: Isothermal Atmosphere

In hydrostatic equilibrium: $\frac{dp}{dz} = -\rho g$

For an ideal gas: $p = \rho RT$ where $T$ is constant.

Therefore: $\rho = \frac{p}{RT}$

Substituting into the hydrostatic equation:
$$
\frac{dp}{dz} = -\frac{pg}{RT} = -\frac{p}{H_s}
$$

where $H_s = RT/g$ is the scale height.

Integrating:
$$
p(z) = p(0)\exp\left(-\frac{z}{H_s}\right)
$$

And from the equation of state:
$$
\rho(z) = \frac{p(z)}{RT} = \rho(0)\exp\left(-\frac{z}{H_s}\right)
$$

For the troposphere, take $T \approx 250$ K:
$$
H_s = \frac{287 \times 250}{9.81} \approx 7.3 \text{ km}
$$

This is indeed on the order of 8 km.

### Exercise 3: Vector Differential Operators

**Divergence** (scalar):
$$
\DIV \uv = \frac{\partial u}{\partial x} + \frac{\partial v}{\partial y} + \frac{\partial w}{\partial z}
$$
Index notation: $\nabla_k u_k$ or $\partial u_k/\partial x_k$

Physical meaning: Rate of volume expansion per unit volume.

**Curl** (vector):
$$
\CURL \uv = \left(\frac{\partial w}{\partial y} - \frac{\partial v}{\partial z}, \frac{\partial u}{\partial z} - \frac{\partial w}{\partial x}, \frac{\partial v}{\partial x} - \frac{\partial u}{\partial y}\right)
$$
Index notation: $\varepsilon_{ijk}\partial u_k/\partial x_j$

Physical meaning: Local rotation or vorticity of the fluid.

**Directional derivative** (scalar operator):
$$
\uv \cdot \GRAD = u\frac{\partial}{\partial x} + v\frac{\partial}{\partial y} + w\frac{\partial}{\partial z}
$$
Index notation: $u_k \partial/\partial x_k$

Physical meaning: Rate of change along the direction of velocity.

**Laplacian** (scalar):
$$
\nabla^2 = \frac{\partial^2}{\partial x^2} + \frac{\partial^2}{\partial y^2} + \frac{\partial^2}{\partial z^2}
$$
Index notation: $\partial^2/\partial x_k \partial x_k$

Physical meaning: Measure of how much a field differs from its average over neighboring points.

### Exercise 4: Pollutant Transport

Given: $\uv = (\alpha x, -\alpha y, 0)$ and $c = c_0 + \gamma t + \beta x^2 y e^{-\alpha t}$

**(a) Eulerian rate of change** (at fixed point):
$$
\frac{\partial c}{\partial t} = \gamma - \alpha\beta x^2 y e^{-\alpha t}
$$

**(b) Lagrangian rate of change** (following parcels):
$$
\frac{Dc}{Dt} = \frac{\partial c}{\partial t} + \uv \cdot \GRAD c
$$

First calculate $\GRAD c$:
$$
\GRAD c = \left(2\beta xy e^{-\alpha t}, \beta x^2 e^{-\alpha t}, 0\right)
$$

Then:
$$
\begin{aligned}
\uv \cdot \GRAD c &= \alpha x(2\beta xy e^{-\alpha t}) + (-\alpha y)(\beta x^2 e^{-\alpha t}) \\
&= 2\alpha\beta x^2y e^{-\alpha t} - \alpha\beta x^2 y e^{-\alpha t} \\
&= \alpha\beta x^2 y e^{-\alpha t}
\end{aligned}
$$

Therefore:
$$
\frac{Dc}{Dt} = \gamma - \alpha\beta x^2 y e^{-\alpha t} + \alpha\beta x^2 y e^{-\alpha t} = \gamma
$$

The concentration increases at constant rate $\gamma$ following fluid parcels!

**(c) Concentration at $t = 1$**:

First find the particle path. The trajectory satisfies:
$$
\frac{dx}{dt} = \alpha x, \quad \frac{dy}{dt} = -\alpha y
$$

Solutions: $x(t) = x_0 e^{\alpha t}$, $y(t) = y_0 e^{-\alpha t}$

Starting at $(x_0, y_0, 0) = (1, 1, 0)$ at $t = 0$:
- At $t = 1$: $x(1) = e^\alpha$, $y(1) = e^{-\alpha}$

Since $Dc/Dt = \gamma$:
$$
c(t) = c(0) + \int_0^t \gamma \, dt' = c(0) + \gamma t
$$

Initial concentration: $c(0) = c_0 + \beta(1)^2(1)e^0 = c_0 + \beta$

Final concentration: $c(1) = c_0 + \beta + \gamma$

### Exercise 7: Pressure in Inviscid Flow

Given: $\uv = (kx, -ky, 0)$ (steady, inviscid, incompressible)

Check incompressibility:
$$
\DIV \uv = k - k + 0 = 0 \quad \checkmark
$$

Calculate the advective acceleration:
$$
(\uv \cdot \GRAD)\uv = \left(kx\frac{\partial}{\partial x} - ky\frac{\partial}{\partial y}\right)(kx, -ky, 0)
= (k^2 x, k^2 y, 0) = \GRAD\left(\frac{k^2x^2}{2} + \frac{k^2y^2}{2}\right)
$$

Euler equation (inviscid Navier-Stokes):
$$
(\uv \cdot \GRAD)\uv = -\frac{1}{\rho}\GRAD p - g\hat{\mathbf{k}}
$$

Therefore:
$$
\GRAD\left(\frac{k^2x^2}{2} + \frac{k^2y^2}{2}\right) = -\frac{1}{\rho}\GRAD p - \GRAD(gz)
$$

Integrating:
$$
p = p_0 - \rho\left(\frac{k^2x^2}{2} + \frac{k^2y^2}{2} + gz\right)
$$

where $p_0$ is the pressure at the origin.

### Exercise 8: Cylindrical Continuity Equation

Transform from Cartesian $(x, y, z)$ to cylindrical $(r, \theta, z)$:
$$
x = r\cos\theta, \quad y = r\sin\theta, \quad z = z
$$

Velocity transformation:
$$
u_r = u\cos\theta + v\sin\theta, \quad u_\theta = -u\sin\theta + v\cos\theta, \quad u_z = w
$$

Using the chain rule:
$$
\frac{\partial}{\partial x} = \cos\theta\frac{\partial}{\partial r} - \frac{\sin\theta}{r}\frac{\partial}{\partial \theta}
\frac{\partial}{\partial y} = \sin\theta\frac{\partial}{\partial r} + \frac{\cos\theta}{r}\frac{\partial}{\partial \theta}
$$

Substitute into the Cartesian continuity equation $\partial u/\partial x + \partial v/\partial y + \partial w/\partial z = 0$ and use the velocity transformations. After simplification using trigonometric identities:
$$
\frac{1}{r}\frac{\partial(ru_r)}{\partial r} + \frac{1}{r}\frac{\partial u_\theta}{\partial \theta} + \frac{\partial u_z}{\partial z} = 0
$$

(sol-inviscid-flows)=
## Steady Inviscid Flows

Exercises: [](#sec-inviscid-flows-exercises).

### Exercise 1: Vector Identity

Start with the term $\mathbf{b} \times (\CURL \mathbf{a})$ in index notation:
$$
\begin{aligned}
[\mathbf{b} \times (\CURL \mathbf{a})]_i &= \varepsilon_{ijk} b_j [\CURL \mathbf{a}]_k \\
&= \varepsilon_{ijk} b_j \varepsilon_{klm} \frac{\partial a_m}{\partial x_l} \\
&= \varepsilon_{kij} \varepsilon_{klm} b_j \frac{\partial a_m}{\partial x_l}
\end{aligned}
$$

Using the identity $\varepsilon_{kij}\varepsilon_{klm} = \delta_{il}\delta_{jm} - \delta_{im}\delta_{jl}$:
$$
= (\delta_{il}\delta_{jm} - \delta_{im}\delta_{jl}) b_j \frac{\partial a_m}{\partial x_l} = b_j \frac{\partial a_j}{\partial x_i} - b_j \frac{\partial a_i}{\partial x_j}
$$

Similarly:
$$
[\mathbf{a} \times (\CURL \mathbf{b})]_i = a_j \frac{\partial b_j}{\partial x_i} - a_j \frac{\partial b_i}{\partial x_j}
$$

Adding these:
$$
\mathbf{b} \times (\CURL \mathbf{a}) + \mathbf{a} \times (\CURL \mathbf{b}) = \GRAD(\mathbf{a} \cdot \mathbf{b}) - (\mathbf{b} \cdot \GRAD)\mathbf{a} - (\mathbf{a} \cdot \GRAD)\mathbf{b}
$$

Rearranging gives the vector identity.

**For the second part**, set $\mathbf{a} = \mathbf{b} = \uv$:
$$
2\uv \times \boldsymbol{\omega} = \GRAD|\uv|^2 - 2(\uv \cdot \GRAD)\uv
$$

Dividing by 2 and rearranging:
$$
(\uv \cdot \GRAD)\uv = \GRAD\left(\frac{1}{2}|\uv|^2\right) - \uv \times \boldsymbol{\omega}
$$

### Exercise 2: Channel Constriction

**Conservation of mass** (volume flux):

Outside constriction (point 1): width $w_1$, depth $h_1 = h$, velocity $u_1 = U$

Inside constriction (point 2): width $w_2 = w_1/2$, depth $h_2 = h/2$, velocity $u_2$

Volume flux: $u_1 h_1 w_1 = u_2 h_2 w_2$

Therefore:
$$
u_2 = u_1 \frac{h_1 w_1}{h_2 w_2} = U \frac{h \cdot w_1}{(h/2) \cdot (w_1/2)} = 4U
$$

**Bernoulli's equation** along surface streamline ($p = p_0$ everywhere):
$$
\frac{u_1^2}{2} + gh_1 = \frac{u_2^2}{2} + gh_2
\frac{U^2}{2} + gh = \frac{(4U)^2}{2} + g\frac{h}{2}
\frac{U^2}{2} + gh = 8U^2 + \frac{gh}{2}
\frac{gh}{2} = \frac{15U^2}{2}
$$

**Result:**
$$
U = \sqrt{\frac{gh}{15}}
$$

### Exercise 3: Building Pressure

There is a **stagnation point** on the upstream side of the building where the wind velocity goes to zero. From Bernoulli's equation:
$$
\frac{1}{2}\rho U_0^2 + p_0 = 0 + p_{\text{stag}}
$$

**Pressure increase:**
$$
\Delta p = p_{\text{stag}} - p_0 = \frac{1}{2}\rho U_0^2
$$

For wind at 100 km/hr = 27.8 m/s and air density $\rho = 1.2$ kg/m³:
$$
\Delta p = \frac{1}{2} \times 1.2 \times (27.8)^2 \approx 464 \text{ Pa}
$$

This is about 0.5% of atmospheric pressure (~ 100 kPa), but represents a significant force on large building faces. For a 10 m × 10 m wall:
$$
F = \Delta p \times A = 464 \times 100 = 46.4 \text{ kN}
$$

### Exercise 5: Bernoulli Paradox

When you blow air between the two sheets, the velocity of air increases in the gap (channeling effect).

According to Bernoulli's equation along a streamline:
$$
\frac{1}{2}\rho v^2 + p = \text{constant}
$$

**Outside the sheets**: $v \approx 0$ (still air), pressure = $p_0$ (atmospheric)

**Between the sheets**: $v > 0$ (moving air), pressure = $p_{\text{gap}}$

Therefore:
$$
\frac{1}{2}\rho v^2 + p_{\text{gap}} \approx p_0
p_{\text{gap}} < p_0
$$

The pressure **between** the sheets is **lower** than atmospheric pressure outside. This pressure difference pushes the sheets **together**.

This is the same principle behind:
- Airplane wings generating lift
- Shower curtains billowing inward
- Spinning balls curving (Magnus effect)

### Exercise 6: Balloon and Tank

**(a) Balloon deflation:**

Inside balloon: $p = p_0 + \Delta p$, $u \approx 0$ (large volume, slow movement)

Outside (at exit): $p = p_0$, $u = U$ (exit velocity)

Bernoulli's equation (ignoring gravity for a small balloon):
$$
\frac{0^2}{2} + \frac{p_0 + \Delta p}{\rho} = \frac{U^2}{2} + \frac{p_0}{\rho}
U = \sqrt{\frac{2\Delta p}{\rho}}
$$

**(b) Tank with waste pipe:**

At top surface: $u \approx 0$, $p = p_0$, elevation = $H$ (unknown)

At waste pipe exit: $u = U$, $p = p_0$, elevation = $-L = -0.01$ m

Bernoulli's equation:
$$
0 + \frac{p_0}{\rho} + gH = \frac{U^2}{2} + \frac{p_0}{\rho} + g(-L)
H = \frac{U^2}{2g} - L
$$

Volume conservation (steady state):
$$
U \cdot A_{\text{pipe}} = Q_{\text{in}}
U = \frac{3 \times 10^{-5}}{2 \times 10^{-5}} = 1.5 \text{ m/s}
$$

Therefore:
$$
H = \frac{(1.5)^2}{2 \times 10} - 0.01 = 0.1125 - 0.01 = 0.1025 \text{ m} \approx 10.3 \text{ cm}
$$

### Exercise 7: Post in River

**(a) Explanation:**

At the upstream face of the post, there is a **stagnation point** where the water velocity becomes zero as it diverts around the post. According to Bernoulli's equation, where velocity decreases, pressure (and hence water level) must increase.

**(b) Height increase:**

Far from post: velocity = $U$, pressure at surface = $p_0$, height = $h_0$

At stagnation point: velocity = 0, pressure at surface = $p_{\text{stag}}$, height = $h_0 + \Delta h$

Bernoulli's equation along surface:
$$
\frac{U^2}{2} + p_0 + \rho g h_0 = 0 + p_{\text{stag}} + \rho g(h_0 + \Delta h)
$$

Since pressure varies hydrostatically near the surface: $p_{\text{stag}} = p_0 + \rho g \Delta h$

Substituting:
$$
\frac{U^2}{2} + p_0 + \rho g h_0 = p_0 + \rho g \Delta h + \rho g h_0 + \rho g \Delta h
\frac{U^2}{2} = 2\rho g \Delta h
$$

Wait, let me reconsider. Actually, at the free surface, $p = p_0$ everywhere. The height change creates the pressure difference:

$$
\frac{U^2}{2} + gh_0 = 0 + g(h_0 + \Delta h)
$$

**Height increase:**
$$
\Delta h = \frac{U^2}{2g}
$$

**(c) Numerical estimate:**

For $U = 1$ m/s:
$$
\Delta h = \frac{1^2}{2 \times 10} = 0.05 \text{ m} = 5 \text{ cm}
$$

This is easily observable!

(sol-nondimensional-equations)=
## Non-dimensional equations & dimensionless numbers

Exercises: [](#sec-nondimensional-equations-exercises).

### Exercise 4: Stream Function Properties

**(a) Incompressibility:**

The divergence of the velocity field is:
$$
\DIV \uv = \frac{\partial u}{\partial x} + \frac{\partial v}{\partial y} = \frac{\partial^2 \psi}{\partial x \partial y} - \frac{\partial^2 \psi}{\partial y \partial x} = 0
$$

The mixed partial derivatives are equal (Schwarz's theorem), so incompressibility is automatically satisfied.

**(b) Streamlines:**

A streamline is tangent to the velocity vector at every point:
$$
\frac{dy}{dx} = \frac{v}{u}
$$

Along a curve of constant $\psi$:
$$
d\psi = \frac{\partial \psi}{\partial x}dx + \frac{\partial \psi}{\partial y}dy = -v\,dx + u\,dy = 0
$$

Therefore: $\frac{dy}{dx} = \frac{v}{u}$, confirming that lines of constant $\psi$ are streamlines.

**(c) Volume flux:**

The volume flux through a curve from point A to point B is:
$$
Q = \int_A^B \uv \cdot \hat{\mathbf{n}} \, ds
$$

where $\hat{\mathbf{n}}$ is the normal to the curve. Using the stream function definition and Stokes' theorem, this equals:
$$
Q = \psi_B - \psi_A
$$

The volume flux between streamlines is simply the difference in their $\psi$ values.

(sol-stress-and-faulting)=
## Stress, Faults and the Mohr Circle

Exercises: [](#sec-stress-and-faulting-exercises).

### Exercise 1: Stress on a fault

Slip requires $\tau \geq C + \mu\sigma_n = C + 0.6 \times 300 = 180 + C$ MPa. The cohesion is never negative, so the shear stress needed for slip is at least $180$ MPa. The fault carries $120$ MPa and should not slip.

### Exercise 3: Anderson's angles

$\phi = \arctan\mu$: $21.8°$ for $\mu = 0.4$ and $40.4°$ for $\mu = 0.85$. Faults form at $45° - \phi/2$ to $\sigma_1$, that is at $34.1°$ and $24.8°$. A normal fault ($\sigma_1$ vertical) therefore dips $90°$ minus these, $55.9°$ and $65.2°$; a thrust ($\sigma_1$ horizontal) dips $34.1°$ and $24.8°$.

(sol-rayleigh-benard-convection)=
## Rayleigh–Bénard Convection

Exercises: [](#sec-rayleigh-benard-convection-exercises).

### Exercise 1: Critical Rayleigh Number

**(a) Physical explanation:**

Convection requires that buoyancy forces overcome viscous resistance. At low Rayleigh numbers, viscous forces are too strong and any perturbation is damped. The critical $Ra_c$ represents the threshold where buoyancy and viscous forces balance.

Below $Ra_c$: Conduction is stable (viscous damping dominates)
Above $Ra_c$: Convection occurs (buoyancy dominates)

**(b) Boundary condition dependence:**

- **Free-slip boundaries**: $Ra_c \approx 657$ (easier to convect)
- **No-slip boundaries**: $Ra_c \approx 1708$ (harder to convect)
- **One free, one no-slip**: $Ra_c \approx 1101$ (intermediate)

No-slip boundaries require higher $Ra$ because they impose additional constraints on the flow, increasing viscous dissipation.

**(c) Wavelength dependence:**

The Rayleigh number in linear stability analysis is wavelength-dependent:
$$
Ra(\lambda) = \frac{g\alpha \Delta T h^3}{\kappa \nu} \cdot f(\lambda/h)
$$

Each wavelength has its own critical value. The global $Ra_c$ is the minimum over all wavelengths. Typically, the most unstable mode has wavelength $\lambda \sim 2h$ (aspect ratio ~ 1), which physical intuition: cells that are too wide or too narrow are less efficient at heat transport.

### Exercise 3: Thermal Boundary Layer

**(a) Boundary layer scaling:**

From boundary layer theory, heat balance gives:
$$
\delta \sim h \cdot Ra^{-1/3}
$$

This comes from balancing vertical advection with vertical diffusion in the thermal boundary layer.

**(b) Mantle calculation:**

With $Ra = 10^7$ and $h = 2900$ km:
$$
\delta \sim 2900 \text{ km} \times (10^7)^{-1/3} \sim 2900/215 \sim 13.5 \text{ km}
$$

**(c) Comparison with D" layer:**

Seismic observations suggest the D" layer (thermal boundary layer at CMB) is $\sim$100-300 km thick. Our estimate is much thinner, suggesting:

1. The D" layer may not be purely thermal (could include chemical layering)
2. Local Rayleigh number near CMB might be lower than whole-mantle value
3. Time-dependent effects and plumes complicate the simple boundary layer picture
4. The scaling assumes steady state, but Earth's convection is time-dependent

This discrepancy is an active research topic!

(sol-analytical-solutions)=
## Benchmark Problems: Analytical Solutions for Viscous Flows

Exercises: [](#sec-analytical-solutions-exercises).

### Exercise 1: Mixed Couette-Poiseuille Flow

**(a) Velocity profile:**

The governing equation is:
$$
\frac{d^2 u}{dz^2} = -\frac{\gamma}{\mu}
$$

Integrating twice:
$$
u = -\frac{\gamma}{2\mu}z^2 + Az + B
$$

Boundary conditions:
- At $z = 0$: $u = 0 \Rightarrow B = 0$
- At $z = h$: $u = U \Rightarrow A = U/h + \gamma h/(2\mu)$

Therefore:
$$
u(z) = \frac{z}{h}\left(U + \frac{\gamma h^2}{2\mu}\right) - \frac{\gamma z^2}{2\mu}
$$

Since the pressure gradient **opposes** the plate motion ($\gamma > 0$), the term $-\gamma z^2/(2\mu)$ reduces the velocity.

**(b) Volume flux:**

$$
Q = \int_0^h u \, dz = \frac{Uh}{2} + \frac{\gamma h^3}{12\mu} - \frac{\gamma h^3}{6\mu} = \frac{Uh}{2} - \frac{\gamma h^3}{12\mu}
$$

**(c) Zero flux condition:**

Setting $Q = 0$:
$$
\frac{Uh}{2} = \frac{\gamma h^3}{12\mu}
\gamma = \frac{6\mu U}{h^2}
$$

This is the pressure gradient magnitude required to exactly oppose the plate-driven flow.

### Exercise 3: Cylindrical Pipe Flow

**(a) Continuity:**

In cylindrical coordinates:
$$
\frac{1}{r}\frac{\partial}{\partial r}(ru_r) + \frac{\partial u_z}{\partial z} = 0
$$

Since we assume $u_z = u_z(r)$ only (axisymmetric, fully-developed flow), $\partial u_z/\partial z = 0$, which gives:
$$
\frac{1}{r}\frac{d}{dr}(ru_r) = 0
$$

Integrating: $ru_r = \text{constant}$. Since $u_r$ must be finite at $r = 0$, the constant must be zero, so $u_r = 0$.

**(b) Governing equation:**

The $z$-component of the Navier-Stokes equation (steady, axisymmetric) is:
$$
-\frac{1}{\rho}\frac{\partial p}{\partial z} + \frac{\nu}{r}\frac{d}{dr}\left(r\frac{du_z}{dr}\right) = 0
$$

Since $p = p(z)$ and $u_z = u_z(r)$:
$$
\frac{dp}{dz} = -\gamma \quad \text{(constant)}
\frac{1}{r}\frac{d}{dr}\left(r\frac{du_z}{dr}\right) = -\frac{\gamma}{\mu}
$$

**(c) Solution:**

Integrating once:
$$
r\frac{du_z}{dr} = -\frac{\gamma r^2}{2\mu} + C_1
$$

For finite velocity at $r = 0$: $C_1 = 0$. Integrating again:
$$
u_z = -\frac{\gamma r^2}{4\mu} + C_2
$$

Boundary condition $u_z(a) = 0$ gives $C_2 = \gamma a^2/(4\mu)$:
$$
u_z(r) = \frac{\gamma a^2}{4\mu}\left(1 - \frac{r^2}{a^2}\right)
$$

**(d) Volume flux:**

$$
Q = \int_0^a u_z \cdot 2\pi r \, dr = 2\pi\frac{\gamma a^2}{4\mu}\int_0^a \left(1 - \frac{r^2}{a^2}\right)r \, dr
Q = \frac{\pi\gamma a^2}{2\mu}\left[\frac{r^2}{2} - \frac{r^4}{4a^2}\right]_0^a = \frac{\pi\gamma a^4}{8\mu}
$$

**(e) Velocity comparison:**

- Maximum velocity: $u_{max} = \gamma a^2/(4\mu)$ at $r = 0$
- Average velocity: $\bar{u} = Q/(\pi a^2) = \gamma a^2/(8\mu)$
- Ratio: $\bar{u}/u_{max} = 1/2$

The average velocity is exactly half the maximum velocity for parabolic pipe flow.

### Exercise 4: Vorticity in Poiseuille Flow

**(a) Vorticity distribution:**

For plane Poiseuille flow [](#eq-poiseuille-solution):
$$
u = \frac{\gamma z}{2\mu}(h - z)
$$

The vorticity (for 2D flow in the $x$-$z$ plane) is:
$$
\omega = \frac{du}{dz} = \frac{\gamma}{2\mu}(h - 2z)
$$

At the boundaries:
- At $z = 0$: $\omega = \gamma h/(2\mu) > 0$ (positive vorticity)
- At $z = h$: $\omega = -\gamma h/(2\mu) < 0$ (negative vorticity)
- At $z = h/2$: $\omega = 0$ (vorticity cancels)

**(b) Mechanism:**

Vorticity is generated at solid boundaries through the no-slip condition. The boundary continuously generates vorticity that diffuses into the interior. The rate of vorticity generation is proportional to the velocity gradient at the wall.

**(c-d) Time-dependent problem:**

For the impulsive start problem, let $\uv = (u(z,t), 0, 0)$. From continuity: $w = 0$.

The $x$-momentum equation is:
$$
\frac{\partial u}{\partial t} = -\frac{1}{\rho}\frac{dp_0}{dx} + \nu\frac{\partial^2 u}{\partial z^2}
$$

Since $dp_0/dx = -\gamma$ (constant), this is:
$$
\frac{\partial u}{\partial t} = \frac{\gamma}{\rho} + \nu\frac{\partial^2 u}{\partial z^2}
$$

**(e) Initial condition:**

At $t = 0$, the fluid is at rest: $u(z, 0) = 0$. The boundary conditions are $u(0,t) = u(h,t) = 0$ for all $t > 0$.

The steady-state solution is the Poiseuille profile. The unsteady solution approaches this as $t \to \infty$.
