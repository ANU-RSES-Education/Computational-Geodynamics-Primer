# Style Guide

This guide provides conventions for writing and formatting content for the Computational Geodynamics Primer.

## File Organization

- Place chapter files in the appropriate subdirectory (e.g., `Part1-Fundamentals/`, `DraftMaterial/`)
- Use descriptive, lowercase filenames with hyphens: `thermal-convection.qmd`
- Store images in `Images/Diagrams/` or `Images/Photos/`

## Mathematical Notation

### Global Macros

We have defined global macros in `_math-preamble.qmd`. Include this at the top of each chapter:

```markdown
```

Available macros include:
- `\uv` - velocity vector $\mathbf{u}$
- `\vv` - velocity vector $\mathbf{v}$
- `\DIV` - divergence operator $\nabla\cdot$
- `\GRAD` - gradient operator $\nabla$
- `\CURL` - curl operator $\nabla\times$
- `\Red{text}` - red text for emphasis
- `\Blue{text}` - blue text
- `\Green{text}` - green text

### Equations

Use display equations with labels for important results:

```markdown
$$
\DIV \sigma + \rho \mathbf{g} = 0
$$ (eq-stokes-momentum)
```

Reference equations using `[](#eq-label)`:

```markdown
The momentum equation [](#eq-stokes-momentum) shows...
```

### Multi-line Equations

For multi-line equations, use the `aligned` or `split` environments:

```markdown
$$
\begin{aligned}
\frac{\partial T}{\partial t} + \uv \cdot \GRAD T &= \kappa \nabla^2 T + H \\
\DIV \uv &= 0
\end{aligned}
$$
```

## Figures

Use Markdown image syntax with labels:

```markdown
:::{figure} ../Images/Diagrams/filename.png
:label: fig-label
:width: 450px
Caption describing the figure
:::
```

Reference figures using `[](#fig-label)`:

```markdown
As shown in [](#fig-convection-cells), the...
```

## Citations

Add references to `references.bib` in BibTeX format. Cite using:

```markdown
The seminal work by @turcotte2014 showed...

Multiple studies [@moresi1995; @tackley2008] have demonstrated...
```

## Code Blocks

### Python Code

For executable Python code using pyodide:

````markdown
```{pyodide-python}
import numpy as np
import matplotlib.pyplot as plt

# Your code here
```
````

For non-executable code examples:

````markdown
```python
# Example code
def solve_stokes(mesh, viscosity):
    # Implementation
    pass
```
````

## Headings

Use hierarchical headings:

```markdown
# Chapter Title (automatically numbered)

## Major Section

### Subsection

#### Minor subsection (use sparingly)
```

## Emphasis and Formatting

- **Bold** for key terms on first use: `**Rayleigh number**`
- *Italics* for emphasis: `*important*`
- Code font for variables and functions: `` `temperature` ``
- Math mode for mathematical symbols: `$\eta$`

## Cross-References

### Internal Links

Link to other chapters:
```markdown
See [Conservation Laws](../DraftMaterial/ContinuumMechanics.md) for details.
```

### Equations in Other Files

When referencing equations from other chapters, use `[](#eq-label)`. Note that cross-file references may generate warnings during single-file rendering.

## Callout Blocks

Use callout blocks to highlight important information:

```markdown
:::{note}
This is a note.
:::

:::{tip}
This is a helpful tip.
:::

:::{warning}
This is a warning about potential issues.
:::

:::{important}
This is important information.
:::

:::{caution}
Exercise caution in this situation.
:::
```

Add `collapse="true"` to make them collapsible:

```markdown
:::{note} Click to expand
:class: dropdown
Hidden content here...
:::
```

## Physical Quantities and Units

- Use SI units by default
- Clearly state non-dimensional forms
- Use consistent notation for physical quantities throughout the book

## Common Notation

- $\eta$ - dynamic viscosity
- $\rho$ - density
- $T$ - temperature
- $\mathbf{u}$, $\mathbf{v}$ - velocity vectors
- $p$ - pressure
- $\kappa$ - thermal diffusivity
- $\alpha$ - thermal expansivity
- $g$ - gravitational acceleration

## Examples

See the [Example: Using Citations and Math](example-citations.md) chapter for a working demonstration of these conventions.
