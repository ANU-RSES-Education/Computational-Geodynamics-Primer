# Steady Inviscid Flows

:::{warning} Under Review
:class: dropdown

This entire chapter is newly added content adapted from ICFM Chapter 3 (Steady Inviscid Flows). While inviscid flow theory is foundational to fluid mechanics, its direct relevance to highly viscous geodynamic flows needs further justification and integration with subsequent chapters on viscous flows.

**Changes made:**
- Converted ~355 lines of LaTeX from ICFM to Quarto format
- Added geodynamic applications throughout (magma ascent, dynamic pressure on lithosphere, core flow)
- Reformulated all equations using global math macros ($\DIV$, $\GRAD$, $\uv$)
- Added 10 exercises with 7 worked solutions
- Created connections to potential flow theory and complex analysis
- Included placeholder figure references (figures need to be created)

**Review needed:**
- Verify geodynamic applications are physically accurate
- Ensure smooth transition from this inviscid chapter to viscous flow chapters
- Add more Earth-specific examples (currently mix of classic fluid mechanics and geophysics)
- Check that mathematical level is appropriate for target audience
- Create actual figures to replace placeholders
:::

## Introduction

Inviscid flow theory provides fundamental insights into fluid motion by examining the limiting case where viscosity is negligible. While no real fluid is truly inviscid, many geophysical flows operate at very low Reynolds numbers where viscous effects are confined to thin boundary layers, and the bulk flow can be approximated as inviscid.

**Why study inviscid flows in geodynamics?**

1. **Flow Topology**: Inviscid solutions reveal the fundamental structure of flow patterns
2. **Analytical Tractability**: Many inviscid problems have exact solutions
3. **Limiting Cases**: Provide benchmarks for understanding viscous flows
4. **Large-Scale Circulation**: Core dynamics and atmospheric flows can be approximated as inviscid away from boundaries
5. **Mathematical Foundation**: Potential flow theory is a cornerstone of analytical fluid mechanics

:::{note} Material adapted from MTH3360 Fluid Mechanics

This chapter is adapted from *MTH3360 Incompressible Fluid Mechanics* course materials (Monash University, 2010-2013), modified to emphasize connections to geodynamics.
:::

## Bernoulli's Equation

### Derivation

For steady inviscid flow under external forces which have a potential $\Omega$ such that $\mathbf{F} = -\GRAD \Omega$, the Euler equation (Navier-Stokes without viscosity) reduces to:
$$
(\uv \cdot \GRAD)\uv = -\frac{1}{\rho}\GRAD p - \GRAD \Omega
$$

For incompressible fluids:
$$
(\uv \cdot \GRAD)\uv + \frac{1}{\rho}\GRAD(p + \rho\Omega) = \mathbf{0}
$$

We may regard $p + \rho\Omega$ as a more general **dynamic pressure**. For gravitational potential, $\Omega = gz$, and $\mathbf{F} = -\GRAD \Omega = -g\hat{\mathbf{k}}$.

To derive Bernoulli's equation, we note that:
$$
\begin{aligned}
\uv \cdot [(\uv \cdot \GRAD)\uv] &= u(\uv \cdot \GRAD)u + v(\uv \cdot \GRAD)v + w(\uv \cdot \GRAD)w \\
&= \uv \cdot \GRAD\left(\frac{1}{2}(u^2 + v^2 + w^2)\right) \\
&= (\uv \cdot \GRAD)\left(\frac{1}{2}|\uv|^2\right)
\end{aligned}
$$

using the fact that $\uv \cdot \GRAD$ is a scalar differential operator. Hence:
$$
\uv \cdot \left[(\uv \cdot \GRAD)\uv + \frac{1}{\rho}\GRAD(p + \rho\Omega)\right] = (\uv \cdot \GRAD)\left(\frac{1}{2}|\uv|^2 + \frac{p}{\rho} + \Omega\right) = 0
$$

Since $\uv \cdot \GRAD$ is the derivative in the direction $\uv$ (tangent to streamlines), it follows that:

**Bernoulli's Equation:**
```{math}
:label: eq-bernoulli
\frac{1}{2}|\uv|^2 + \frac{p}{\rho} + \Omega = \text{constant along each streamline}
```

although the constant will generally be different on different streamlines.

### Physical Interpretation

Bernoulli's equation [](#eq-bernoulli) represents energy conservation along a streamline:

- $\frac{1}{2}|\uv|^2$ = kinetic energy per unit mass
- $\frac{p}{\rho}$ = pressure work per unit mass
- $\Omega$ = potential energy per unit mass

The sum remains constant as a fluid parcel moves along its streamline.

### Common Forms of the Potential

**Gravitational potential:**
$$
\Omega = gz
$$

**Rotating reference frame:**
$$
\Omega = gz - \frac{\omega^2 r^2}{2}
$$

where $\omega$ is the rotation rate and $r$ is the distance from the rotation axis.

:::{tip} Example: Rotating Fluid Surface

In a 'static' fluid in a rotating reference frame, verify that $\Omega = gz - \omega^2 r^2/2$ predicts that the free surface takes the form of a parabola.

**Solution:** At the free surface, $p = p_0$ (atmospheric) and $\uv = \mathbf{0}$ (static). Bernoulli's equation gives:
$$
gz - \frac{\omega^2 r^2}{2} = \text{constant}
$$

Therefore:
$$
z = z_0 + \frac{\omega^2 r^2}{2g}
$$

This is indeed a parabola opening upward. This is observed in rotating buckets of water and explains the shape of liquid telescope mirrors.
:::

## Applications of Bernoulli's Equation

### Torricelli's Theorem: Draining a Reservoir

::::{figure}
:label: fig-torricelli
```{image} ../Images/Diagrams/draining-tank.svg
:alt: A tank of water with a small opening at the bottom of its right wall. A dashed streamline runs from point B on the free surface down to point A at the opening, a height h below; a curved jet leaves the opening with velocity u A. The surface is at atmospheric pressure p 0.
:class: dark:hidden
```
```{image} ../Images/Diagrams/draining-tank-dark.svg
:alt: A tank of water with a small opening at the bottom of its right wall. A dashed streamline runs from point B on the free surface down to point A at the opening, a height h below; a curved jet leaves the opening with velocity u A. The surface is at atmospheric pressure p 0.
:class: hidden dark:block
```
Flow from a draining tank through a small orifice Point $B$ on the free surface and the exit $A$ are both at atmospheric pressure $p_0$; Bernoulli's equation along the streamline from $B$ to $A$ (dashed) gives $u_A = \sqrt{2gh}$.
::::

Consider a large reservoir with a small drainage hole at the bottom. If the opening is much smaller than the reservoir cross-section, the water surface falls very slowly and the flow may be regarded as approximately steady.

At the exit (point A):
- Pressure: $p_A = p_0$ (atmospheric)
- Velocity: $u_A$ (to be determined)

At the surface (point B):
- Pressure: $p_B = p_0$ (atmospheric)
- Velocity: $u_B \approx 0$ (slow descent)
- Height above exit: $h$

Applying Bernoulli's equation along streamline AB:
$$
\frac{1}{2}u_A^2 + \frac{p_0}{\rho} = \frac{1}{2}u_B^2 + \frac{p_0}{\rho} + gh
$$

Since $u_B \ll u_A$:

**Torricelli's Theorem:**
```{math}
:label: eq-torricelli
u_A = \sqrt{2gh}
```

The outflow speed is that of free fall from height $h$ under gravity. This neglects viscous dissipation of energy.

### Geodynamic Application: Magma Ascent

Torricelli's theorem can be adapted to estimate magma ascent velocities. For a magma chamber at depth $h$ beneath a volcanic vent:
$$
u_{\text{exit}} \approx \sqrt{2g'h}
$$

where $g' = g\Delta\rho/\rho$ is the reduced gravity accounting for buoyancy. For $\Delta\rho/\rho \sim 0.1$ and $h \sim 5$ km:
$$
u_{\text{exit}} \sim \sqrt{2 \times 10 \times 0.1 \times 5000} \sim 30 \text{ m/s}
$$

This provides a rough estimate for effusive eruption velocities (actual values modified by viscosity, conduit friction, and gas content).

### Stagnation Pressure and the Pitot Tube

::::{figure}
:label: fig-stagnation
```{image} ../Images/Diagrams/stagnation-point.svg
:alt: Streamlines of a uniform stream curving around a circular body. The central streamline runs along the axis and ends at a dot S on the front of the body, labelled p stag. Arrows on the left mark the oncoming stream U 0 at pressure p 0.
:class: dark:hidden
```
```{image} ../Images/Diagrams/stagnation-point-dark.svg
:alt: Streamlines of a uniform stream curving around a circular body. The central streamline runs along the axis and ends at a dot S on the front of the body, labelled p stag. Arrows on the left mark the oncoming stream U 0 at pressure p 0.
:class: hidden dark:block
```
Flow around a bluff body showing the stagnation point. The dividing streamline ends at the stagnation point $S$, where the flow is brought to rest and the pressure rises to $p_{\text{stag}}$.
::::

Suppose a stream has uniform speed $U_0$ and pressure $p_0$ far from an obstacle. As it flows around a bluff body, the flow must slow down in front, creating a **dividing streamline** that separates fluid passing on either side. This streamline ends at a **stagnation point** where the velocity is zero.

Applying Bernoulli's equation from the free stream to the stagnation point:
$$
\frac{1}{2}\rho U_0^2 + p_0 = 0 + p_{\text{stag}}
$$

**Stagnation Pressure:**
```{math}
:label: eq-stagnation-pressure
p_{\text{stag}} = p_0 + \frac{1}{2}\rho U_0^2
```

The pressure $p_{\text{stag}}$ is the **total** or **Pitot pressure** (also called the **total head**), differing from the static pressure $p_0$ by the **dynamic pressure** $\frac{1}{2}\rho U_0^2$.

### The Pitot Tube

::::{figure}
:label: fig-pitot
```{image} ../Images/Diagrams/pitot-tube.svg
:alt: A channel with flow U 0 from the left. An L-shaped tube faces upstream at mid-depth and rises to a vertical column; a second column rises from a tap in the channel wall. The liquid in the first column stands higher than in the second by Delta h.
:class: dark:hidden
```
```{image} ../Images/Diagrams/pitot-tube-dark.svg
:alt: A channel with flow U 0 from the left. An L-shaped tube faces upstream at mid-depth and rises to a vertical column; a second column rises from a tap in the channel wall. The liquid in the first column stands higher than in the second by Delta h.
:class: hidden dark:block
```
Pitot tube for measuring flow velocity via pressure measurement The tube facing upstream senses the stagnation pressure $p_{\text{stag}}$; the tap in the wall, normal to the flow, senses the static pressure $p_0$. The difference in level $\Delta h$ measures $p_{\text{stag}} - p_0 = \tfrac{1}{2}\rho U_0^2$.
::::

A Pitot tube consists of a tube directed into the stream with a small central hole connected to a manometer. At equilibrium, there is no flow through the tube, so the measured pressure is the total pressure:
$$
U_0 = \sqrt{\frac{2(p_{\text{stag}} - p_0)}{\rho}}
$$

The static pressure $p_0$ can be obtained from a **static tube** oriented normal to the flow.

### Geodynamic Application: Dynamic Pressure on Lithosphere

The concept of dynamic pressure is relevant to understanding forces on the lithosphere. For mantle flow with velocity $U$ impinging on the base of the lithosphere, the dynamic pressure is:
$$
p_{\text{dyn}} = \frac{1}{2}\rho U^2
$$

For typical mantle flow $U \sim 50$ mm/yr $= 1.6 \times 10^{-9}$ m/s and $\rho = 3300$ kg/m³:
$$
p_{\text{dyn}} \sim \frac{1}{2} \times 3300 \times (1.6 \times 10^{-9})^2 \sim 4 \times 10^{-15} \text{ Pa}
$$

This is negligible compared to lithostatic pressure (~GPa), confirming that dynamic pressure effects are unimportant in mantle convection—viscous stresses dominate.

## Vector Identity for Vorticity

A useful vector identity relates the advective acceleration to vorticity:

**Vector Identity:**
```{math}
:label: eq-vorticity-identity
(\uv \cdot \GRAD)\uv = \GRAD\left(\frac{1}{2}|\uv|^2\right) - \uv \times \boldsymbol{\omega}
```

where $\boldsymbol{\omega} = \CURL \uv$ is the **vorticity**.

This identity allows us to rewrite the Euler equation as:
$$
\frac{\partial \uv}{\partial t} + \GRAD\left(\frac{1}{2}|\uv|^2\right) - \uv \times \boldsymbol{\omega} = -\frac{1}{\rho}\GRAD p - \GRAD \Omega
$$

For **irrotational flow** where $\boldsymbol{\omega} = \mathbf{0}$, the equation simplifies significantly, leading to potential flow theory.

## Irrotational Flow and Velocity Potential

### Definition

A flow is **irrotational** if the vorticity vanishes everywhere:
$$
\CURL \uv = \mathbf{0}
$$

From vector calculus, any irrotational vector field can be expressed as the gradient of a scalar **velocity potential** $\phi$:
```{math}
:label: eq-velocity-potential
\uv = \GRAD \phi
```

### Incompressible Irrotational Flow

For incompressible flow, $\DIV \uv = 0$. Substituting [](#eq-velocity-potential):
$$
\DIV (\GRAD \phi) = \nabla^2 \phi = 0
$$

**Laplace's Equation:**
```{math}
:label: eq-laplace
\nabla^2 \phi = 0
```

This is the governing equation for incompressible, irrotational (potential) flow. Laplace's equation is linear and has extensive mathematical theory, making potential flows analytically tractable.

### Bernoulli's Equation for Irrotational Flow

For irrotational flow, [](#eq-vorticity-identity) gives:
$$
(\uv \cdot \GRAD)\uv = \GRAD\left(\frac{1}{2}|\uv|^2\right)
$$

The unsteady Euler equation becomes:
$$
\frac{\partial \uv}{\partial t} + \GRAD\left(\frac{1}{2}|\uv|^2\right) = -\frac{1}{\rho}\GRAD p - \GRAD \Omega
$$

Since $\uv = \GRAD \phi$:
$$
\GRAD\left(\frac{\partial \phi}{\partial t}\right) + \GRAD\left(\frac{1}{2}|\GRAD \phi|^2\right) = -\frac{1}{\rho}\GRAD p - \GRAD \Omega
$$

Integrating:

**Unsteady Bernoulli's Equation (irrotational):**
```{math}
:label: eq-unsteady-bernoulli
\frac{\partial \phi}{\partial t} + \frac{1}{2}|\GRAD \phi|^2 + \frac{p}{\rho} + \Omega = f(t)
```

where $f(t)$ is an arbitrary function of time (can be absorbed into $\phi$ by redefining the potential).

For **steady** irrotational flow:
```{math}
:label: eq-steady-irrotational-bernoulli
\frac{1}{2}|\uv|^2 + \frac{p}{\rho} + \Omega = \text{constant everywhere}
```

Unlike the general case [](#eq-bernoulli), Bernoulli's constant is the **same on all streamlines** for irrotational flow.

### Geodynamic Relevance of Potential Flow

While the mantle is highly viscous and far from inviscid, potential flow concepts remain relevant:

1. **Core Dynamics**: The liquid outer core has low viscosity; large-scale flow may approximate potential flow away from boundaries
2. **Atmospheric/Ocean Circulation**: Geostrophic flows in rotating systems often have irrotational components
3. **Crustal Fluids**: Groundwater flow in porous media often satisfies Laplace's equation
4. **Mathematical Methods**: Analytical techniques from potential flow transfer to other Laplacian fields (temperature, pressure in porous media)

## Stream Function (2D Flows)

For two-dimensional incompressible flow in the $x$-$y$ plane, we can define a **stream function** $\psi(x,y)$ such that:
```{math}
:label: eq-stream-function
u = \frac{\partial \psi}{\partial y}, \quad v = -\frac{\partial \psi}{\partial x}
```

This automatically satisfies incompressibility:
$$
\DIV \uv = \frac{\partial u}{\partial x} + \frac{\partial v}{\partial y} = \frac{\partial^2 \psi}{\partial x \partial y} - \frac{\partial^2 \psi}{\partial y \partial x} = 0
$$

### Properties of Stream Function

1. **Streamlines** are curves of constant $\psi$
2. **Volume flux** between two streamlines equals $\Delta \psi$
3. For **irrotational** 2D flow: $\nabla^2 \psi = 0$ (Laplace's equation)

### Relationship to Velocity Potential (2D)

For 2D irrotational flow, both $\phi$ and $\psi$ exist:
$$
u = \frac{\partial \phi}{\partial x} = \frac{\partial \psi}{\partial y}, \quad v = \frac{\partial \phi}{\partial y} = -\frac{\partial \psi}{\partial x}
$$

These are the **Cauchy-Riemann equations**, indicating that $\phi$ and $\psi$ are harmonic conjugates. This connects potential flow to complex analysis.

## Complex Potential (2D Flows)

For 2D incompressible, irrotational flow, we can define a **complex potential**:
$$
F(z) = \phi(x,y) + i\psi(x,y)
$$

where $z = x + iy$ is the complex coordinate.

The **complex velocity** is:
$$
w(z) = \frac{dF}{dz} = u - iv
$$

This powerful formulation allows us to use complex analysis to solve flow problems. Standard complex functions generate useful flow patterns:

- **Uniform flow**: $F = U_0 z$
- **Source/Sink**: $F = \frac{Q}{2\pi}\ln z$
- **Vortex**: $F = -i\frac{\Gamma}{2\pi}\ln z$
- **Doublet**: $F = \frac{\mu}{z}$

Superposition of these elementary solutions can model complex flows around obstacles.

(sec-inviscid-flows-exercises)=
## Exercises

:::{note} Solutions
:class: solutions-link
Exercises marked {sup}`★` have worked solutions in [](#sol-inviscid-flows).
:::

### Exercise 1: Vector Identity {sup}`★`

Prove the vector identity:
$$
\GRAD(\mathbf{a} \cdot \mathbf{b}) = (\mathbf{b} \cdot \GRAD)\mathbf{a} + (\mathbf{a} \cdot \GRAD)\mathbf{b} + \mathbf{b} \times (\CURL \mathbf{a}) + \mathbf{a} \times (\CURL \mathbf{b})
$$

Hence show that:
$$
(\uv \cdot \GRAD)\uv = \GRAD\left(\frac{1}{2}|\uv|^2\right) - \uv \times \boldsymbol{\omega}
$$

where $\boldsymbol{\omega} = \CURL \uv$ is the vorticity.

### Exercise 2: Channel Flow with Constriction {sup}`★`

A uniform straight open rectangular channel carries water flow of mean speed $U$ and depth $h$. The channel has a constriction that reduces its width by half, and it is observed that the depth of water in the constriction is only $h/2$.

By applying Bernoulli's theorem to a surface streamline, find $U$ in terms of $g$ and $h$.

### Exercise 3: Pressure on Buildings {sup}`★`

Explain why there is an increase in pressure on the side of a building facing the wind. Estimate the force per unit area on a building face when the wind speed is 100 km/hr.

**Hint**: Consider the stagnation point concept.

### Exercise 4: Curl and Divergence

Calculate the curl and divergence of the Cartesian velocity field:
$$
\uv = \left[z - \frac{2x}{r}, 2y - 3z - \frac{2y}{r}, x - 3y - \frac{2z}{r}\right]
$$

where $r = \sqrt{x^2 + y^2 + z^2}$. Is this flow incompressible or irrotational?

### Exercise 5: Bernoulli Paradox {sup}`★`

Hold two sheets of paper parallel to each other with a small gap between them. Blow air between the sheets. Contrary to intuition, the sheets move **together** rather than apart.

Explain this phenomenon using Bernoulli's equation, assuming steady flow.

### Exercise 6: Balloon Deflation {sup}`★`

Using Bernoulli's equation:

a) Show that air from a balloon at excess pressure $p_1$ above atmospheric will emerge with approximate speed $\sqrt{2p_1/\rho}$

b) Find the depth of water in steady state in a vessel that is filled at constant rate $3 \times 10^{-5}$ m³/s and has a waste pipe of length 0.01 m and cross-sectional area $2 \times 10^{-5}$ m² protruding vertically below its base

### Exercise 7: Post in River {sup}`★`

A vertical round post stands in a river, and it is observed that the water level at the upstream face of the post is slightly higher than the level at some distance to either side.

a) Explain why this occurs

b) Find the increase in height in terms of surface stream speed $U$ and acceleration of gravity $g$

c) Estimate the increase in height for a stream with undisturbed surface speed 1 m/s

### Exercise 8: Velocity Potential for Simple Flows

For each of the following velocity fields, determine if the flow is irrotational. If so, find the velocity potential $\phi$:

a) $\uv = (y, -x, 0)$ (rigid body rotation)

b) $\uv = (x, y, 0)$ (radial flow from origin)

c) $\uv = (kx, -ky, 0)$ (hyperbolic flow)

### Exercise 9: Geostrophic Flow in Core

The flow in Earth's liquid outer core is influenced by both buoyancy and rotation. Consider a simplified model where large-scale flow is approximately geostrophic (balanced by Coriolis and pressure gradient forces).

a) Estimate the typical velocity in the core using the geostrophic balance

b) Calculate the Reynolds number for core flow

c) Discuss whether inviscid flow approximations are appropriate

### Exercise 10: Magma Chamber Dynamics

A magma chamber at depth $h = 5$ km beneath a volcano has excess pressure $\Delta p = 50$ MPa relative to the surrounding rock. A conduit of diameter $d = 10$ m opens to the surface.

a) Estimate the exit velocity using Bernoulli's equation (assume inviscid flow)

b) Calculate the volume flux

c) Discuss limitations of the inviscid approximation for magma (typical viscosity $\eta \sim 10^3$ Pa·s)

## Summary

This chapter introduced inviscid flow theory and Bernoulli's equation, fundamental tools for understanding fluid motion:

1. **Bernoulli's equation** expresses energy conservation along streamlines in inviscid flow
2. **Stagnation pressure** occurs where flow velocity reaches zero
3. **Torricelli's theorem** describes drainage from reservoirs
4. **Irrotational flows** can be described by a velocity potential satisfying Laplace's equation
5. **Stream functions** provide an alternative description for 2D incompressible flow
6. **Complex potentials** enable powerful analytical solutions using complex analysis

While geodynamic flows are generally viscous, inviscid theory provides:
- Fundamental insights into flow topology
- Limiting case benchmarks
- Mathematical techniques applicable to related fields
- Understanding of large-scale circulation patterns

In the next chapter, we examine **vortex motion** and the dynamics of vorticity, building on these inviscid flow concepts.

## References

The material in this chapter is adapted from:

- **MTH3360 Incompressible Fluid Mechanics**, Louis Moresi, Monash University, 2010-2013
- @batchelor1967: *An Introduction to Fluid Dynamics* - comprehensive treatment of potential flow
- @acheson1990: *Elementary Fluid Dynamics* - accessible introduction with applications
