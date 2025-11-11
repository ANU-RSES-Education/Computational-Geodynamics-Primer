# Markup Style Guide: Technical Formatting

This guide covers the **technical aspects of formatting content** using Quarto markdown (.qmd files). For content organization and writing style, see the Writing Style Guide.

## File Organization

### File Naming
- Use descriptive, lowercase filenames with hyphens
- Examples: `heat-conduction.qmd`, `stokes-equation.qmd`
- Avoid: `HeatConduction.qmd`, `heat_conduction.qmd`, `chapter1.qmd`

### File Location
- Place chapter files in appropriate subdirectories:
  - `Part1-Fundamentals/` - Mathematical foundations
  - `Part2-FluidDynamics/` - Fluid dynamics theory
  - `Part3-Geodynamics/` - Geodynamic applications
  - `Part4-NumericalMethods/` - Numerical methods
  - `Part5-Computational/` - Computational exercises
  - `DraftMaterial/` - Work in progress (temporary)

### Image Organization
- Store images in appropriate directories:
  - `Images/Diagrams/` - Scientific diagrams, schematics
  - `Images/Photos/` - Photographs, satellite images
  - `Images/` - General figures

## Document Structure

### Front Matter
Every chapter should begin with:
```markdown
---
title: "Chapter Title"
---
```

### Including Math Preamble
Include the shared mathematical notation definitions at the top of each chapter:
```markdown
{{< include ../_math-preamble.qmd >}}
```
This provides access to all global math macros.

### Heading Hierarchy
Use hierarchical headings (Quarto automatically numbers them):

```markdown
# Chapter Title (Level 1 - for chapter files only)

## Major Section (Level 2)

### Subsection (Level 3)

#### Minor subsection (Level 4 - use sparingly)
```

**Guidelines:**
- Level 1 (`#`) for chapter titles only
- Use Level 2 (`##`) for main sections
- Use Level 3 (`###`) for subsections
- Avoid Level 5+ (restructure content if needed)

## Mathematical Notation

### Global Macros
The following macros are defined in `_math-preamble.qmd`:

**Vector operators:**
- `\uv` → $\mathbf{u}$ (velocity vector)
- `\vv` → $\mathbf{v}$ (velocity vector)
- `\DIV` → $\nabla\cdot$ (divergence)
- `\GRAD` → $\nabla$ (gradient)
- `\CURL` → $\nabla\times$ (curl)

**Colored text (use sparingly for emphasis):**
- `\Red{text}` → red text
- `\Blue{text}` → blue text
- `\Green{text}` → green text

### Display Equations

**Simple equation:**
```markdown
$$
\DIV \sigma + \rho \mathbf{g} = 0
$$
```

**Numbered equation with label:**
```markdown
$$
\DIV \sigma + \rho \mathbf{g} = 0
$$ {#eq-stokes-momentum}
```

**Referencing equations:**
```markdown
The momentum equation @eq-stokes-momentum shows...
```

### Multi-line Equations

Use `aligned` environment for multiple equations:
```markdown
$$
\begin{aligned}
\frac{\partial T}{\partial t} + \uv \cdot \GRAD T &= \kappa \nabla^2 T + H \\
\DIV \uv &= 0
\end{aligned}
$$ {#eq-thermal-convection}
```

### Inline Math
Use single dollar signs for inline math:
```markdown
The Rayleigh number $Ra = \frac{\alpha g \Delta T h^3}{\kappa \nu}$ determines...
```

### Common Conventions
Following standard notation (see also Writing Style Guide):
- $\eta$ - dynamic viscosity
- $\rho$ - density
- $T$ - temperature
- $\mathbf{u}$, $\mathbf{v}$ - velocity vectors
- $p$ - pressure
- $\kappa$ - thermal diffusivity
- $\alpha$ - thermal expansivity
- $g$ - gravitational acceleration

## Figures and Images

### Basic Figure Syntax
```markdown
![Caption describing the figure](../Images/Diagrams/filename.png){#fig-label width=450px}
```

### Figure Components
- **Alt text** (before bracket): Descriptive text for screen readers
- **Path** (in parentheses): Relative path from current file
- **Label** (in braces): Use `#fig-` prefix for cross-referencing
- **Width** (optional): Specify size in px or %

### Figure Referencing
```markdown
As shown in @fig-convection-cells, the flow pattern...
```

### Multi-panel Figures
```markdown
::: {#fig-comparison layout-ncol=2}

![Panel A description](images/panel-a.png){#fig-panel-a}

![Panel B description](images/panel-b.png){#fig-panel-b}

Comparison of two scenarios
:::
```

### Figure Guidelines
- Always include descriptive alt text
- Use relative paths from the .qmd file location
- Prefer vector formats (SVG, PDF) when possible
- Label all figures for cross-referencing
- Specify width to control sizing (typically 400-600px)

## Code Blocks

### Jupyter Notebooks (Preferred)
For computational content, use separate `.ipynb` files and link to them:
```markdown
See the [interactive notebook](../Notebooks/heat-conduction.ipynb) for implementation.
```

### Display-Only Python Code
For showing code without execution:
````markdown
```python
def solve_stokes(mesh, viscosity):
    """
    Solve the Stokes equation for incompressible flow.
    """
    # Implementation here
    pass
```
````

### Interactive Python (Pyodide)
For simple examples that run in the browser:
````markdown
```{pyodide-python}
import numpy as np
import matplotlib.pyplot as plt

x = np.linspace(0, 2*np.pi, 100)
y = np.sin(x)
plt.plot(x, y)
plt.show()
```
````

**Limitations:** Pyodide only supports basic packages (numpy, matplotlib, scipy). For advanced examples, use notebooks with Binder.

### Bash/Shell Commands
````markdown
```bash
quarto preview WebBook
```
````

## Citations and References

### Citation Syntax

**Single author in text:**
```markdown
As shown by @turcotte2014, the thermal structure...
```

**Multiple citations:**
```markdown
Previous studies [@moresi1995; @tackley2008] have demonstrated...
```

**Parenthetical citation:**
```markdown
The Boussinesq approximation is commonly used [@boussinesq1903].
```

### Bibliography Management
- Add references to `references.bib` in BibTeX format
- Use consistent citation keys: `authorYEARword` format
  - Example: `turcotte2014geodynamics`, `moresi1995mantle`
- Include DOI when available

### BibTeX Entry Example
```bibtex
@book{turcotte2014geodynamics,
  title={Geodynamics},
  author={Turcotte, Donald L and Schubert, Gerald},
  year={2014},
  publisher={Cambridge University Press},
  edition={3},
  doi={10.1017/CBO9780511843877}
}
```

## Cross-References

### Internal Links

**Link to another chapter:**
```markdown
See [Conservation Laws](../DraftMaterial/ContinuumMechanics.qmd) for details.
```

**Link to specific section:**
```markdown
See [Section on Boundary Conditions](../Part1-Fundamentals/mathematical-background.qmd#boundary-conditions).
```

### Cross-File References
- Equations: `@eq-label` works across files
- Figures: `@fig-label` works across files
- May generate warnings during single-file preview (normal behavior)

## Callout Blocks

### Available Types

**Note (general information):**
```markdown
:::{.callout-note}
This is a note with general information.
:::
```

**Tip (helpful suggestion):**
```markdown
:::{.callout-tip}
A useful tip for readers.
:::
```

**Warning (potential pitfall):**
```markdown
:::{.callout-warning}
Be careful with this approach because...
:::
```

**Important (critical information):**
```markdown
:::{.callout-important}
This is crucial to understand.
:::
```

**Caution (proceed carefully):**
```markdown
:::{.callout-caution}
Exercise caution when interpreting...
:::
```

### Collapsible Callouts
Add `collapse="true"` for optional content:
```markdown
:::{.callout-note collapse="true"}
## Advanced Topic: Additional Details
This content is hidden by default...
:::
```

### Titled Callouts
```markdown
:::{.callout-tip}
## Pro Tip
Always check dimensional consistency...
:::
```

## Lists

### Unordered Lists
```markdown
- First item
- Second item
  - Nested item
  - Another nested item
- Third item
```

### Ordered Lists
```markdown
1. First step
2. Second step
3. Third step
```

### Definition Lists
```markdown
Term 1
: Definition of term 1

Term 2
: Definition of term 2
```

## Tables

### Simple Table
```markdown
| Parameter | Symbol | Units | Typical Value |
|-----------|--------|-------|---------------|
| Viscosity | $\eta$ | Pa·s  | $10^{21}$     |
| Density   | $\rho$ | kg/m³ | $3300$        |
```

### Table with Caption
```markdown
| Parameter | Value |
|-----------|-------|
| $Ra$      | $10^6$ |
| $Pr$      | $10^{23}$ |

: Parameter values for mantle convection {#tbl-parameters}
```

Reference with: `@tbl-parameters`

## Text Formatting

### Basic Formatting
- **Bold**: `**important term**` → **important term**
- *Italic*: `*emphasis*` → *emphasis*
- `Code`: `` `variable_name` `` → `variable_name`
- Math: `$\alpha$` → $\alpha$

### Usage Guidelines
- **Bold** for key terms on first use: `**Rayleigh number**`
- *Italic* for emphasis (use sparingly)
- `Code font` for variables, filenames, commands
- Math mode for all mathematical symbols and variables

## Special Quarto Features

### Margin Notes
```markdown
This is regular text [and this appears in the margin]{.aside}.
```

### Tabsets
```markdown
::: {.panel-tabset}

## Tab 1
Content for tab 1

## Tab 2
Content for tab 2

:::
```

### Conditional Content
```markdown
::: {.content-visible when-format="html"}
This only appears in HTML output
:::

::: {.content-visible when-format="pdf"}
This only appears in PDF output
:::
```

## File Templates

### Chapter Template
```markdown
---
title: "Chapter Title"
---

{{< include ../_math-preamble.qmd >}}

# Introduction

[Brief overview of chapter]

## Section 1

[Content]

### Subsection 1.1

[Content]

## Section 2

[Content]

## Summary

[Key takeaways]

## Further Reading

- @author2020 - Description
- @another2019 - Description
```

### Module Template
```markdown
---
title: "Module Title"
---

{{< include ../_math-preamble.qmd >}}

## Introduction

[2-3 sentences: What, why, connections]

## Mathematical Framework

[Core equations and derivation]

## Implementation

See [computational notebook](../Notebooks/module-example.ipynb).

## Earth Applications

[Real-world examples]

## Exercises

1. **Check understanding**: [Question]
2. **Computational**: [Notebook-based exercise]
3. **Application**: [Real-world problem]

## Further Reading

- Citation with brief description
```

## Common Pitfalls

### Paths
❌ Absolute paths: `/Users/name/project/Images/fig.png`
✅ Relative paths: `../Images/Diagrams/fig.png`

### Math
❌ Text mode for variables: `The viscosity eta`
✅ Math mode for variables: `The viscosity $\eta$`

### Figures
❌ No alt text: `![](image.png)`
✅ With alt text: `![Convection cell diagram](image.png)`

### Code Blocks
❌ Using pyodide for complex packages: `{pyodide-python}` with pandas
✅ Use separate notebook: Link to `.ipynb` file with Binder

### Labels
❌ Generic labels: `{#eq-1}`, `{#fig-a}`
✅ Descriptive labels: `{#eq-stokes-momentum}`, `{#fig-convection-pattern}`

## Preview and Build

### Local Preview
```bash
quarto preview WebBook
```
- Fast iterative development
- Auto-rebuilds on save
- Live reload in browser

### Full Build
```bash
quarto render WebBook
python serve-book.py
```
- Required for testing embedded content
- Resolves all cross-references
- Production-ready output

### Using Pixi
```bash
pixi install
pixi run quarto preview
```

## Validation Checklist

Before committing content:

- [ ] File named with lowercase and hyphens
- [ ] Math preamble included
- [ ] All equations properly formatted
- [ ] Figures have alt text and labels
- [ ] Cross-references use @ syntax
- [ ] Citations in references.bib
- [ ] Code blocks use appropriate language tags
- [ ] Relative paths used throughout
- [ ] Headings follow hierarchy
- [ ] Previews without errors
- [ ] All images load correctly

---

For questions about markup not covered here, consult the [Quarto documentation](https://quarto.org/docs/authoring/).