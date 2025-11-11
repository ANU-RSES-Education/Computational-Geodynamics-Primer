# Navigation Structure: Recommendations and Implementation

This document describes the navigation hierarchy for the Computational Geodynamics Primer and how to implement deeper nesting for modular content organization.

## Current Structure (Two Levels)

The book currently uses a two-level hierarchy:

```yaml
- part: "Part Name"
  chapters:
    - chapter1.qmd
    - chapter2.qmd
```

**Limitations:**
- No grouping within parts
- All chapters appear at same level
- Difficult to organize multiple related modules
- Long lists in sidebar become unwieldy

## Recommended Structure (Three Levels)

To support modular organization, implement a three-level hierarchy:

**Level 1: Parts** - Major divisions (Mathematical Fundamentals, Fluid Dynamics, etc.)
**Level 2: Sections** - Thematic groupings or topics within parts
**Level 3: Modules** - Individual 2-3 page content units

### Example Structure

```yaml
- part: "Part III: Geodynamics"
  chapters:
    - Part3-Geodynamics/intro.qmd

    - section: "Theme 1: Heat Conduction"
      chapters:
        - Part3-Geodynamics/HeatConduction/fundamentals.qmd
        - Part3-Geodynamics/HeatConduction/analytical-solutions.qmd
        - Part3-Geodynamics/HeatConduction/applications.qmd

    - section: "Theme 2: Mantle Convection"
      chapters:
        - Part3-Geodynamics/MantleConvection/physical-setup.qmd
        - Part3-Geodynamics/MantleConvection/simple-convection.qmd
        - Part3-Geodynamics/MantleConvection/earth-applications.qmd

    - section: "Theme 3: Stokes Flow"
      chapters:
        - Part3-Geodynamics/StokesFlow/derivation.qmd
        - Part3-Geodynamics/StokesFlow/solution-methods.qmd
        - Part3-Geodynamics/StokesFlow/applications.qmd
```

## Sidebar Configuration

### Collapse Behavior

Control how many levels are expanded by default:

```yaml
# In _quarto.yml under sidebar:
sidebar:
  style: "docked"
  background: light
  collapse-level: 2  # Show parts and sections, collapse modules
```

**Options:**
- `collapse-level: 1` - Only parts visible, sections collapsed
- `collapse-level: 2` - Parts and sections visible, modules collapsed (recommended)
- `collapse-level: 3` - Everything expanded (use for shorter books only)

### Complete Configuration

```yaml
book:
  sidebar:
    logo: assets/AuWorldEQ.jpg
    style: "docked"
    background: light
    collapse-level: 2
    search: true
    pinned: true  # Keep sidebar visible
```

## Implementation Examples

### Example 1: Vertical Strand Organization

For the first complete vertical strand (Background → Applications):

```yaml
- part: "**Demonstration Strand: Heat Transfer**"
  chapters:
    # Foundation modules
    - section: "Background & Foundations"
      chapters:
        - FoundationStrand/background-mathematics.qmd
        - FoundationStrand/background-geodynamics.qmd
        - FoundationStrand/constants-reference.qmd

    # Theme 1: Heat Conduction
    - section: "Theme 1: Heat Conduction"
      chapters:
        - FoundationStrand/HeatConduction/module1-fundamentals.qmd
        - FoundationStrand/HeatConduction/module2-analytical.qmd
        - FoundationStrand/HeatConduction/module3-applications.qmd

    # Theme 2: Mantle Convection
    - section: "Theme 2: Mantle Convection"
      chapters:
        - FoundationStrand/MantleConvection/module1-setup.qmd
        - FoundationStrand/MantleConvection/module2-simple.qmd
        - FoundationStrand/MantleConvection/module3-earth.qmd

    # Theme 3: Stokes Flow
    - section: "Theme 3: Stokes Equation"
      chapters:
        - FoundationStrand/StokesFlow/module1-derivation.qmd
        - FoundationStrand/StokesFlow/module2-methods.qmd
        - FoundationStrand/StokesFlow/module3-applications.qmd
```

### Example 2: Traditional Part Organization

For complete parts with multiple topics:

```yaml
- part: "**Part II: Fluid Dynamics**"
  chapters:
    - Part2-FluidDynamics/introduction.qmd

    - section: "Inviscid Flow"
      chapters:
        - Part2-FluidDynamics/Inviscid/potential-flow.qmd
        - Part2-FluidDynamics/Inviscid/bernoulli.qmd
        - Part2-FluidDynamics/Inviscid/vorticity.qmd

    - section: "Viscous Flow"
      chapters:
        - Part2-FluidDynamics/Viscous/navier-stokes.qmd
        - Part2-FluidDynamics/Viscous/boundary-layers.qmd
        - Part2-FluidDynamics/Viscous/pipe-flow.qmd

    - section: "Advanced Topics"
      chapters:
        - Part2-FluidDynamics/Advanced/turbulence.qmd
        - Part2-FluidDynamics/Advanced/multiphase.qmd
```

### Example 3: Computational Exercises

Organizing by skill level or topic:

```yaml
- part: "**Part V: Computational Exercises**"
  chapters:
    - Part5-Computational/introduction.qmd

    - section: "Basic Programming"
      chapters:
        - Part5-Computational/Basic/python-intro.qmd
        - Part5-Computational/Basic/numpy-arrays.qmd
        - Part5-Computational/Basic/visualization.qmd

    - section: "Numerical Methods"
      chapters:
        - Part5-Computational/Numerical/finite-difference.qmd
        - Part5-Computational/Numerical/integration.qmd
        - Part5-Computational/Numerical/linear-systems.qmd

    - section: "Applications"
      chapters:
        - Part5-Computational/Applications/cooling-models.qmd
        - Part5-Computational/Applications/convection-sim.qmd
        - Part5-Computational/Applications/benchmarks.qmd
```

## Directory Structure

Organize files to match navigation structure:

```
WebBook/
├── FoundationStrand/           # Demonstration vertical strand
│   ├── background-mathematics.qmd
│   ├── constants-reference.qmd
│   ├── HeatConduction/
│   │   ├── module1-fundamentals.qmd
│   │   ├── module2-analytical.qmd
│   │   └── module3-applications.qmd
│   ├── MantleConvection/
│   │   ├── module1-setup.qmd
│   │   ├── module2-simple.qmd
│   │   └── module3-earth.qmd
│   └── StokesFlow/
│       ├── module1-derivation.qmd
│       ├── module2-methods.qmd
│       └── module3-applications.qmd
│
├── Part2-FluidDynamics/
│   ├── introduction.qmd
│   ├── Inviscid/
│   │   ├── potential-flow.qmd
│   │   └── bernoulli.qmd
│   └── Viscous/
│       ├── navier-stokes.qmd
│       └── boundary-layers.qmd
│
└── Notebooks/                  # Associated Jupyter notebooks
    ├── heat-conduction-1d.ipynb
    ├── mantle-convection-basic.ipynb
    └── stokes-corner-flow.ipynb
```

## Navigation Best Practices

### Naming Conventions

**Parts:** Use full descriptive names with "Part N:" prefix
```yaml
- part: "**Part III: Geodynamics**"
```

**Sections:** Use concise thematic names, optionally numbered
```yaml
- section: "Theme 1: Heat Conduction"
- section: "Inviscid Flow"
- section: "1. Mathematical Foundations"
```

**Modules/Chapters:** Use descriptive filenames, avoid numbers in files
```yaml
- Part3-Geodynamics/HeatConduction/fundamentals.qmd  # Good
- Part3-Geodynamics/HeatConduction/module1.qmd       # Avoid
```

### Grouping Strategy

**Group by:**
- **Skill progression** (Basic → Intermediate → Advanced)
- **Conceptual themes** (Heat Transfer, Momentum Transport, etc.)
- **Application domains** (Lithosphere, Mantle, Core)
- **Methodology** (Analytical, Numerical, Observational)

**Avoid grouping by:**
- Arbitrary page counts
- Chronological order (unless pedagogically necessary)
- Author or source

### Section Length

**Ideal:** 3-5 modules per section
- Fewer than 3: Consider merging sections
- More than 7: Consider splitting into subsections

**Exception:** Foundation sections can be shorter (1-2 modules)

## Accessibility Considerations

### Screen Reader Navigation

With three-level structure:
1. Parts are `<h2>` landmarks
2. Sections are `<h3>` sub-landmarks
3. Modules are `<h4>` links

Ensure proper hierarchy for navigation.

### Keyboard Navigation

Test that users can:
- Tab through navigation items
- Use arrow keys to expand/collapse
- Enter to navigate to content
- See focus indicators clearly

### Visual Clarity

- Use indentation to show hierarchy
- Maintain consistent spacing
- Provide visual expand/collapse indicators
- Highlight current location

## Migration Strategy

### Phase 1: Create Foundation Strand Structure

```yaml
- part: "**Demonstration Strand**"
  chapters:
    - section: "Foundations"
      chapters:
        - FoundationStrand/background-math.qmd
        - FoundationStrand/constants.qmd

    - section: "Theme 1: Heat Conduction"
      chapters:
        # New modular content
```

### Phase 2: Reorganize Draft Material

Move from flat draft structure to themed sections:

```yaml
# OLD (flat):
- part: "Draft: Geodynamics"
  chapters:
    - DraftMaterial/ContinuumMechanics.qmd
    - DraftMaterial/NavierStokes.qmd
    - DraftMaterial/MantleDynamics.qmd

# NEW (grouped):
- part: "Part III: Geodynamics"
  chapters:
    - section: "Fundamentals"
      chapters:
        - Part3-Geodynamics/Fundamentals/continuum-mechanics.qmd
        - Part3-Geodynamics/Fundamentals/conservation-laws.qmd

    - section: "Flow Equations"
      chapters:
        - Part3-Geodynamics/Flow/navier-stokes.qmd
        - Part3-Geodynamics/Flow/stokes-approximation.qmd
```

### Phase 3: Expand Horizontally

Add new themes using established structure:

```yaml
- section: "Theme 4: Elastic Deformation"
  chapters:
    - Part3-Geodynamics/Elasticity/module1-fundamentals.qmd
    - Part3-Geodynamics/Elasticity/module2-applications.qmd
```

## Testing Navigation

### Check List

- [ ] All levels collapse/expand correctly
- [ ] Current page highlighted in sidebar
- [ ] Breadcrumbs show correct path
- [ ] Section titles descriptive and concise
- [ ] No orphaned or misplaced modules
- [ ] Depth appropriate (not too deep, not too flat)
- [ ] Mobile navigation works
- [ ] Keyboard navigation functional
- [ ] Screen reader navigation logical

### Preview Commands

```bash
# Quick preview
quarto preview WebBook

# Full render to test all navigation
quarto render WebBook
python serve-book.py
```

## Advanced Options

### Custom Section Styling

Add custom CSS for section headings:

```css
/* In assets/styles.css */
.sidebar-section-heading {
  font-weight: 600;
  color: #C58812;  /* ANU gold */
  margin-top: 1em;
}
```

### Conditional Navigation

Show/hide sections based on format:

```yaml
- section: "Interactive Exercises"
  contents:
    - when: "format == 'html'"
      chapters:
        - exercises/interactive1.qmd
    - when: "format == 'pdf'"
      chapters:
        - exercises/printable1.qmd
```

### Custom Icons

Add icons to sections (requires custom HTML):

```yaml
- section: "🔥 Theme 1: Heat Conduction"
- section: "🌊 Theme 2: Mantle Convection"
- section: "⚗️ Theme 3: Stokes Flow"
```

## Examples from Template

Minimal working example to test three-level navigation:

```yaml
book:
  title: "Test Book"
  chapters:
    - part: "Test Part"
      chapters:
        - index.qmd

        - section: "Test Section"
          chapters:
            - chapter1.qmd
            - chapter2.qmd
            - chapter3.qmd

  sidebar:
    style: "docked"
    collapse-level: 2
```

## Summary

**Key Recommendations:**
1. Use three-level hierarchy: Parts → Sections → Modules
2. Set `collapse-level: 2` for optimal UX
3. Group 3-5 modules per section
4. Use descriptive names at all levels
5. Organize files to mirror navigation structure
6. Test keyboard and screen reader navigation
7. Start with demonstration strand, then expand

This structure provides:
- ✅ Clear organization for growing content
- ✅ Manageable sidebar even with many modules
- ✅ Flexible grouping for different pedagogical approaches
- ✅ Accessible navigation for all users
- ✅ Scalable architecture for future expansion