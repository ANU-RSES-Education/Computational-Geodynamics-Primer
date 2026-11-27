# Example: Using Citations and Math

This chapter demonstrates how to use citations and mathematics in the book, showing both the source markup and the rendered output.

For complete documentation, see the [MyST guide](https://mystmd.org/guide) and specifically:

- [Equations](https://mystmd.org/guide/math)
- [Citations](https://mystmd.org/guide/citations)
- [Cross-references](https://mystmd.org/guide/cross-references)

## Citations

### Source Markup

```markdown
For a comprehensive introduction to geodynamics, see @turcotte2014.
The numerical methods for mantle convection are well described in @zhong2007.

Multiple citations can be grouped: [@moresi1995; @moresi1996; @tackley2008].

For fluid dynamics fundamentals, classic texts include @batchelor1967 and @acheson1990.
```

### Rendered Output

For a comprehensive introduction to geodynamics, see @turcotte2014. The numerical methods for mantle convection are well described in @zhong2007.

Multiple citations can be grouped: [@moresi1995; @moresi1996; @tackley2008].

For fluid dynamics fundamentals, classic texts include @batchelor1967 and @acheson1990.

## Mathematics with Proper Rendering


### Inline Math

#### Source Markup

```markdown
The Stokes equation for incompressible flow is $\DIV \sigma = \rho \mathbf{g}$
where $\sigma$ is the stress tensor and $\rho$ is density.
```

#### Rendered Output

The Stokes equation for incompressible flow is $\DIV \sigma = \rho \mathbf{g}$ where $\sigma$ is the stress tensor and $\rho$ is density.

### Display Equations with Labels

#### Source Markup

````markdown
```{math}
:label: eq-stokes-momentum
\DIV \sigma + \rho \mathbf{g} = 0
```

```{math}
:label: eq-incompressible
\DIV \uv = 0
```

We can reference equations: The momentum equation [](#eq-stokes-momentum)
combined with incompressibility [](#eq-incompressible) forms the basis of
mantle convection modeling.
````

#### Rendered Output

```{math}
:label: eq-stokes-momentum
\DIV \sigma + \rho \mathbf{g} = 0
```

```{math}
:label: eq-incompressible
\DIV \uv = 0
```

We can reference equations: The momentum equation [](#eq-stokes-momentum) combined with incompressibility [](#eq-incompressible) forms the basis of mantle convection modeling.

### Multi-line Equations

#### Source Markup

````markdown
```{math}
:label: eq-thermal-system
\begin{aligned}
\frac{\partial T}{\partial t} + \uv \cdot \GRAD T &= \kappa \nabla^2 T + H \\
\DIV \uv &= 0 \\
\rho &= \rho_0(1 - \alpha T)
\end{aligned}
```
````

#### Rendered Output

```{math}
:label: eq-thermal-system
\begin{aligned}
\frac{\partial T}{\partial t} + \uv \cdot \GRAD T &= \kappa \nabla^2 T + H \\
\DIV \uv &= 0 \\
\rho &= \rho_0(1 - \alpha T)
\end{aligned}
```

The thermal convection system [](#eq-thermal-system) couples temperature and velocity.

## Colored Math (for emphasis)

### Source Markup

```markdown
The $\Red{red}$ terms represent heating, while $\Blue{blue}$ terms represent cooling:

$$
\frac{\partial T}{\partial t} + \uv \cdot \GRAD T = \kappa \nabla^2 T + \Red{H} - \Blue{L}
$$
```

### Rendered Output

The $\Red{red}$ terms represent heating, while $\Blue{blue}$ terms represent cooling:

$$
\frac{\partial T}{\partial t} + \uv \cdot \GRAD T = \kappa \nabla^2 T + \Red{H} - \Blue{L}
$$

## Figures

### Source Markup

```markdown
:::{figure} ../Images/Diagrams/layer.png
:label: fig-layer-example
:alt: A horizontal fluid layer of depth d between two boundaries.
:width: 350px
Consider the fluid motions in a layer of arbitrary depth, $d$. The fluid is
assumed to have constant properties such as viscosity, thermal expansivity,
thermal diffusivity.
:::

As shown in [](#fig-layer-example), the layer has depth $d$.
```

### Rendered Output

:::{figure} ../Images/Diagrams/layer.png
:label: fig-layer-example
:alt: A horizontal fluid layer of depth d between two boundaries.
:width: 350px
Consider the fluid motions in a layer of arbitrary depth, $d$. The fluid is assumed to have constant properties such as viscosity, thermal expansivity, thermal diffusivity.
:::

As shown in [](#fig-layer-example), the layer has depth $d$.

## Code Blocks

### Python Code (Display Only)

#### Source Markup

````markdown
```python
import numpy as np

def rayleigh_number(rho, g, alpha, delta_T, d, kappa, eta):
    """Calculate Rayleigh number for thermal convection."""
    return (rho * g * alpha * delta_T * d**3) / (kappa * eta)
```
````

#### Rendered Output

```python
import numpy as np

def rayleigh_number(rho, g, alpha, delta_T, d, kappa, eta):
    """Calculate Rayleigh number for thermal convection."""
    return (rho * g * alpha * delta_T * d**3) / (kappa * eta)
```

### Interactive Python

In-browser execution is not configured yet. MyST supports it through Thebe with JupyterLite or Binder; until then, runnable examples go in notebooks.

## Using Global Macros

### Source Markup

The macros are defined once, under `math:` in `WebBook/myst.yml`; nothing needs to be included at the top of a file. Use them directly:

```markdown
- Velocity: $\uv$ or $\vv$
- Divergence: $\DIV \uv = 0$
- Gradient: $\GRAD T$
- Curl: $\CURL \mathbf{B}$
- Colored text: $\Red{important}$, $\Blue{cold}$, $\Green{check}$
```

### Rendered Output

Rendered with the macros from `myst.yml`:

- Velocity: $\uv$ or $\vv$
- Divergence: $\DIV \uv = 0$
- Gradient: $\GRAD T$
- Curl: $\CURL \mathbf{B}$
- Colored text: $\Red{important}$, $\Blue{cold}$, $\Green{check}$

## Admonitions

Admonitions are useful for highlighting important information, tips, warnings, and notes. See the [MyST admonitions documentation](https://mystmd.org/guide/admonitions). for more details.

### Source Markup

````markdown
:::{note} Note Title (optional)

This is a note admonition. Use it for general information that readers should be aware of.
:::

:::{tip} Tip: Numerical Stability

When implementing finite difference schemes, always check the CFL condition:
$$
\Delta t \leq \frac{\Delta x^2}{2\kappa}
$$
:::

:::{warning} Warning

The Boussinesq approximation breaks down when density variations exceed
approximately 10% of the reference density.
:::

:::{important} Important: Sign Conventions

In this book, we use the convention that tensile stress is positive and
compressive stress is negative.
:::

:::{caution} Caution: Computational Cost

Three-dimensional calculations can be extremely expensive. A grid with
$100^3$ points requires solving systems with ~1 million unknowns.
:::
````

### Rendered Output

:::{note} Note Title (optional)

This is a note admonition. Use it for general information that readers should be aware of.
:::

:::{tip} Tip: Numerical Stability

When implementing finite difference schemes, always check the CFL condition:
$$
\Delta t \leq \frac{\Delta x^2}{2\kappa}
$$
:::

:::{warning} Warning

The Boussinesq approximation breaks down when density variations exceed approximately 10% of the reference density.
:::

:::{important} Important: Sign Conventions

In this book, we use the convention that tensile stress is positive and compressive stress is negative.
:::

:::{caution} Caution: Computational Cost

Three-dimensional calculations can be extremely expensive. A grid with $100^3$ points requires solving systems with ~1 million unknowns.
:::

### Collapsible Admonitions

Add `:class: dropdown` to make an admonition collapsible (closed by default):

#### Source Markup

````markdown
:::{note} Derivation Details (click to expand)
:class: dropdown

Here's the detailed derivation that advanced readers might want to see,
but beginners can skip:

Starting from the continuity equation...
[lengthy derivation]
:::
````

#### Rendered Output

:::{note} Derivation Details (click to expand)
:class: dropdown

Here's the detailed derivation that advanced readers might want to see, but beginners can skip:

Starting from the continuity equation, we apply the divergence theorem and integrate by parts to obtain the weak formulation...
:::

## References

Each page lists the works it cites at the end of the page, built automatically from the `.bib` files named in `myst.yml`.
