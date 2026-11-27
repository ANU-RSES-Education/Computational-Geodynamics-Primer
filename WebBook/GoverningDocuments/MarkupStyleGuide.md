# Markup Style Guide: Technical Formatting

This guide covers the **technical aspects of formatting content** using MyST markdown (`.md` files, built with mystmd). For content organization and writing style, see the Writing Style Guide.

## File Organization

### File Naming
- Use descriptive, lowercase filenames with hyphens
- Examples: `heat-conduction.md`, `stokes-equation.md`
- Avoid: `HeatConduction.md`, `heat_conduction.md`, `chapter1.md`
- **File names must be unique across the whole book.** MyST takes a page's URL from its file name, not its folder: `Part4-NumericalMethods/fem-introduction.md` is published at `/fem-introduction`.
- Do not rename a published page without checking who links to it; the Part IV pages are cited from outside the book.

### File Location
- Place chapter files in appropriate subdirectories:
  - `Part1-Fundamentals/` - Mathematical foundations
  - `Part2-FluidDynamics/` - Fluid dynamics theory
  - `Part3-Geodynamics/` - Geodynamic applications
  - `Part4-NumericalMethods/` - Numerical methods
  - `Part5-Computational/` - Computational exercises
  - `DraftMaterial/` - Work in progress (temporary)
- A page appears in the book only once it is listed under `toc` in `WebBook/myst.yml`.

### Image Organization
- Store images in appropriate directories:
  - `Images/Diagrams/` - Scientific diagrams, schematics (sources for redrawn figures in `Images/Diagrams/src/`)
  - `Images/Photos/` - Photographs, satellite images
  - `Images/` - General figures

## Document Structure

### Front Matter
Front matter is optional. Without it, the first `#` heading is the page title. Use it when the page needs a title different from its heading, or extra metadata:
```markdown
---
title: Chapter Title
---
```

### Mathematical Macros
There is nothing to include at the top of a chapter. The shared notation is defined once, under `math:` in `WebBook/myst.yml`, and is available on every page. Add new macros there rather than defining them in a page.

### Heading Hierarchy
Use hierarchical headings:

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

**Labelling a section** for cross-referencing: put the target on the line above the heading.
```markdown
(sec-boundary-conditions)=
## Boundary Conditions
```

## Mathematical Notation

Maths is rendered with KaTeX.

### Global Macros
The following macros are defined in `WebBook/myst.yml`:

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
````markdown
```{math}
:label: eq-stokes-momentum
\DIV \sigma + \rho \mathbf{g} = 0
```
````

**Referencing equations:**
```markdown
The momentum equation [](#eq-stokes-momentum) shows...
```
This renders as "Equation (n)". Use `` {eq}`eq-stokes-momentum` `` for the number alone, "(n)".

### Multi-line Equations

Use `aligned` environment for multiple equations:
````markdown
```{math}
:label: eq-thermal-convection
\begin{aligned}
\frac{\partial T}{\partial t} + \uv \cdot \GRAD T &= \kappa \nabla^2 T + H \\
\DIV \uv &= 0
\end{aligned}
```
````

KaTeX does not support `eqnarray`, `\intertext` or `\textcolor[rgb]{…}`. Use `aligned` or `array`, a `\text{…}` row, and named colours (`\textcolor{firebrick}{…}`) instead.

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
:::{figure} ../Images/Diagrams/filename.svg
:label: fig-label
:alt: Description of what the figure shows, for screen readers
:width: 80%
Caption describing the figure.
:::
```

### Figure Components
- **Path** (after `{figure}`): Relative path from current file
- **Label** (`:label:`): Use `fig-` prefix for cross-referencing
- **Alt text** (`:alt:`): Descriptive text for screen readers
- **Width** (`:width:`, optional): Size in px or %
- **Caption** (body): What is plotted and how to read it

### Figure Referencing
```markdown
As shown in [](#fig-convection-cells), the flow pattern...
```

### Multi-panel Figures
Images inside a figure directive become sub-figures, lettered (a), (b):
```markdown
:::{figure}
:label: fig-comparison
![Panel A description](images/panel-a.png)
![Panel B description](images/panel-b.png)

Comparison of two scenarios
:::
```
For drawn diagrams, prefer a single multi-panel figure made in one source file (see `Images/Diagrams/src/`).

### Figure Guidelines
- Always include descriptive alt text
- Use relative paths from the `.md` file location
- Prefer vector formats (SVG) when possible
- Label all figures for cross-referencing
- Specify width to control sizing (typically 400-600px)
- Redrawn diagrams follow the Underworld line-diagram house style; see `Images/Diagrams/src/README.md`

## Code Blocks

### Jupyter Notebooks (Preferred)
For computational content, use separate `.ipynb` files. MyST can include a notebook as a page of the book (list it in the `toc` in `myst.yml`), or you can link to it:
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

### Interactive Python
In-browser execution is not configured yet. MyST supports it through Thebe with JupyterLite or Binder; until it is set up, put runnable examples in notebooks and link to them through Binder.

### Bash/Shell Commands
````markdown
```bash
pixi run start
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
- Add references to `references.bib` (or `geodynamics-references.bib`) in BibTeX format; both are listed under `bibliography` in `myst.yml`
- Use consistent citation keys: `authorYEARword` format
  - Example: `turcotte2014geodynamics`, `moresi1995mantle`
- Include DOI when available
- Each page lists the works it cites; there is no separate references page

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
See [Conservation Laws](../Part1-Fundamentals/conservation-laws.md) for details.
```

**Link to specific section** (labelled as shown under Heading Hierarchy):
```markdown
See [](#sec-boundary-conditions).
```
Empty link text is filled with the section title; write your own text inside the brackets to override it.

### Cross-File References
- Equations: `[](#eq-label)` works across files
- Figures: `[](#fig-label)` works across files
- Tables and sections: `[](#tbl-label)`, `[](#sec-label)`
- A label that cannot be found is reported as a warning in the build

## Admonitions

### Available Types

**Note (general information):**
```markdown
:::{note}
This is a note with general information.
:::
```

**Tip (helpful suggestion):**
```markdown
:::{tip}
A useful tip for readers.
:::
```

**Warning (potential pitfall):**
```markdown
:::{warning}
Be careful with this approach because...
:::
```

**Important (critical information):**
```markdown
:::{important}
This is crucial to understand.
:::
```

**Caution (proceed carefully):**
```markdown
:::{caution}
Exercise caution when interpreting...
:::
```

MyST also provides `seealso`, `hint`, `attention`, `danger` and `error`.

### Collapsible Admonitions
Add `:class: dropdown` for optional content (used for worked solutions):
```markdown
:::{note} Advanced Topic: Additional Details
:class: dropdown
This content is hidden by default...
:::
```

### Titled Admonitions
The title follows the directive name:
```markdown
:::{tip} Pro Tip
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
:::{table} Parameter values for mantle convection
:label: tbl-parameters
| Parameter | Value |
|-----------|-------|
| $Ra$      | $10^6$ |
| $Pr$      | $10^{23}$ |
:::
```

Reference with: `[](#tbl-parameters)`

## Text Formatting

### Basic Formatting
- **Bold**: `**important term**` → **important term**
- *Italic*: `*emphasis*` → *emphasis*
- `Code`: `` `variable_name` `` → `variable_name`
- Math: `$\alpha$` → $\alpha$
- Superscript/subscript outside maths: `` {sup}`★` ``, `` {sub}`2` ``

### Usage Guidelines
- **Bold** for key terms on first use: `**Rayleigh number**`
- *Italic* for emphasis (use sparingly)
- `Code font` for variables, filenames, commands
- Math mode for all mathematical symbols and variables

## Other MyST Features

### Margin Notes
```markdown
:::{margin}
This appears in the margin.
:::
```

### Tabsets
```markdown
::::{tab-set}
:::{tab-item} Tab 1
Content for tab 1
:::
:::{tab-item} Tab 2
Content for tab 2
:::
::::
```
When directives are nested, the outer fence needs more colons than the inner one.

## File Templates

### Chapter Template
```markdown
# Chapter Title

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
# Module Title

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

❌ Macros defined in a page: `$$ \newcommand{\uv}{…} $$`
✅ Macros added once to `math:` in `myst.yml`

### Figures
❌ No alt text: `![](image.png)`
✅ With alt text: a figure directive with `:alt:`

### File Names
❌ Two pages with the same file name in different folders (their URLs collide)
✅ Unique, descriptive file names

### Labels
❌ Generic labels: `eq-1`, `fig-a`
✅ Descriptive labels: `eq-stokes-momentum`, `fig-convection-pattern`

## Preview and Build

### Local Preview
```bash
pixi run start
```
- Serves the book at http://localhost:3000
- Rebuilds on save
- Live reload in browser

### Full Build
```bash
pixi run build
```
- Writes the static site to `WebBook/_build/html`
- Reports missing images and unresolved cross-references
- Same command the publishing workflow runs

### Figures
```bash
pixi run figures
```
- Rebuilds every figure from its source in `Images/Diagrams/src/`

## Validation Checklist

Before committing content:

- [ ] File named with lowercase and hyphens, unique in the book
- [ ] Page listed in `toc` in `myst.yml`
- [ ] All equations properly formatted (KaTeX-compatible)
- [ ] Figures have alt text and labels
- [ ] Cross-references use `[](#label)` syntax
- [ ] Citations in references.bib
- [ ] Code blocks use appropriate language tags
- [ ] Relative paths used throughout
- [ ] Headings follow hierarchy
- [ ] `pixi run build` reports no new warnings
- [ ] All images load correctly

---

For questions about markup not covered here, consult the [MyST documentation](https://mystmd.org/guide).
