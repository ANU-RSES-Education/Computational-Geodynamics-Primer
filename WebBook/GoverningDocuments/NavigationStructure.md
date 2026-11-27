# Navigation Structure: Recommendations and Implementation

This document describes the navigation hierarchy for the Computational Geodynamics Primer and how to implement deeper nesting for modular content organization.

## Current Structure (Two Levels)

The book currently uses a two-level hierarchy:

```yaml
- title: "Part Name"
  children:
    - file: chapter1.md
    - file: chapter2.md
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
- title: "Part III: Geodynamics"
  children:
    - file: Part3-Geodynamics/intro.md

    - title: "Theme 1: Heat Conduction"
      children:
        - file: Part3-Geodynamics/HeatConduction/fundamentals.md
        - file: Part3-Geodynamics/HeatConduction/analytical-solutions.md
        - file: Part3-Geodynamics/HeatConduction/applications.md

    - title: "Theme 2: Mantle Convection"
      children:
        - file: Part3-Geodynamics/MantleConvection/physical-setup.md
        - file: Part3-Geodynamics/MantleConvection/simple-convection.md
        - file: Part3-Geodynamics/MantleConvection/earth-applications.md

    - title: "Theme 3: Stokes Flow"
      children:
        - file: Part3-Geodynamics/StokesFlow/derivation.md
        - file: Part3-Geodynamics/StokesFlow/solution-methods.md
        - file: Part3-Geodynamics/StokesFlow/applications.md
```

## Sidebar Configuration

The MyST book theme builds the sidebar from the `toc` in `WebBook/myst.yml`: entries with `children` become collapsible groups, and the group containing the current page opens automatically. There is no separate sidebar configuration and no collapse-level setting.

### Complete Configuration

```yaml
project:
  toc:
    - file: index.md
    - title: "Part III: Geodynamics"
      children:
        - file: Part3-Geodynamics/geodynamics.md
site:
  options:
    logo: Images/ANU-logo.jpg
    logo_text: Computational Geodynamics Primer
```

## Implementation Examples

### Example 1: Vertical Strand Organization

For the first complete vertical strand (Background → Applications):

```yaml
- title: "**Demonstration Strand: Heat Transfer**"
  children:
    # Foundation modules
    - title: "Background & Foundations"
      children:
        - file: FoundationStrand/background-mathematics.md
        - file: FoundationStrand/background-geodynamics.md
        - file: FoundationStrand/constants-reference.md

    # Theme 1: Heat Conduction
    - title: "Theme 1: Heat Conduction"
      children:
        - file: FoundationStrand/HeatConduction/module1-fundamentals.md
        - file: FoundationStrand/HeatConduction/module2-analytical.md
        - file: FoundationStrand/HeatConduction/module3-applications.md

    # Theme 2: Mantle Convection
    - title: "Theme 2: Mantle Convection"
      children:
        - file: FoundationStrand/MantleConvection/module1-setup.md
        - file: FoundationStrand/MantleConvection/module2-simple.md
        - file: FoundationStrand/MantleConvection/module3-earth.md

    # Theme 3: Stokes Flow
    - title: "Theme 3: Stokes Equation"
      children:
        - file: FoundationStrand/StokesFlow/module1-derivation.md
        - file: FoundationStrand/StokesFlow/module2-methods.md
        - file: FoundationStrand/StokesFlow/module3-applications.md
```

### Example 2: Traditional Part Organization

For complete parts with multiple topics:

```yaml
- title: "**Part II: Fluid Dynamics**"
  children:
    - file: Part2-FluidDynamics/introduction.md

    - title: "Inviscid Flow"
      children:
        - file: Part2-FluidDynamics/Inviscid/potential-flow.md
        - file: Part2-FluidDynamics/Inviscid/bernoulli.md
        - file: Part2-FluidDynamics/Inviscid/vorticity.md

    - title: "Viscous Flow"
      children:
        - file: Part2-FluidDynamics/Viscous/navier-stokes.md
        - file: Part2-FluidDynamics/Viscous/boundary-layers.md
        - file: Part2-FluidDynamics/Viscous/pipe-flow.md

    - title: "Advanced Topics"
      children:
        - file: Part2-FluidDynamics/Advanced/turbulence.md
        - file: Part2-FluidDynamics/Advanced/multiphase.md
```

### Example 3: Computational Exercises

Organizing by skill level or topic:

```yaml
- title: "**Part V: Computational Exercises**"
  children:
    - file: Part5-Computational/introduction.md

    - title: "Basic Programming"
      children:
        - file: Part5-Computational/Basic/python-intro.md
        - file: Part5-Computational/Basic/numpy-arrays.md
        - file: Part5-Computational/Basic/visualization.md

    - title: "Numerical Methods"
      children:
        - file: Part5-Computational/Numerical/finite-difference.md
        - file: Part5-Computational/Numerical/integration.md
        - file: Part5-Computational/Numerical/linear-systems.md

    - title: "Applications"
      children:
        - file: Part5-Computational/Applications/cooling-models.md
        - file: Part5-Computational/Applications/convection-sim.md
        - file: Part5-Computational/Applications/benchmarks.md
```

## Directory Structure

Organize files to match navigation structure:

```
WebBook/
├── FoundationStrand/           # Demonstration vertical strand
│   ├── background-mathematics.md
│   ├── constants-reference.md
│   ├── HeatConduction/
│   │   ├── module1-fundamentals.md
│   │   ├── module2-analytical.md
│   │   └── module3-applications.md
│   ├── MantleConvection/
│   │   ├── module1-setup.md
│   │   ├── module2-simple.md
│   │   └── module3-earth.md
│   └── StokesFlow/
│       ├── module1-derivation.md
│       ├── module2-methods.md
│       └── module3-applications.md
│
├── Part2-FluidDynamics/
│   ├── introduction.md
│   ├── Inviscid/
│   │   ├── potential-flow.md
│   │   └── bernoulli.md
│   └── Viscous/
│       ├── navier-stokes.md
│       └── boundary-layers.md
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
- title: "**Part III: Geodynamics**"
```

**Sections:** Use concise thematic names, optionally numbered
```yaml
- title: "Theme 1: Heat Conduction"
- title: "Inviscid Flow"
- title: "1. Mathematical Foundations"
```

**Modules/Chapters:** Use descriptive filenames, avoid numbers in files
```yaml
- file: Part3-Geodynamics/HeatConduction/fundamentals.md  # Good
- file: Part3-Geodynamics/HeatConduction/module1.md       # Avoid
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
- title: "**Demonstration Strand**"
  children:
    - title: "Foundations"
      children:
        - file: FoundationStrand/background-math.md
        - file: FoundationStrand/constants.md

    - title: "Theme 1: Heat Conduction"
      children:
        # New modular content
```

### Phase 2: Reorganize Draft Material

Move from flat draft structure to themed sections:

```yaml
# OLD (flat):
- title: "Draft: Geodynamics"
  children:
    - file: DraftMaterial/ContinuumMechanics.md
    - file: DraftMaterial/NavierStokes.md
    - file: DraftMaterial/MantleDynamics.md

# NEW (grouped):
- title: "Part III: Geodynamics"
  children:
    - title: "Fundamentals"
      children:
        - file: Part3-Geodynamics/Fundamentals/continuum-mechanics.md
        - file: Part3-Geodynamics/Fundamentals/conservation-laws.md

    - title: "Flow Equations"
      children:
        - file: Part3-Geodynamics/Flow/navier-stokes.md
        - file: Part3-Geodynamics/Flow/stokes-approximation.md
```

### Phase 3: Expand Horizontally

Add new themes using established structure:

```yaml
- title: "Theme 4: Elastic Deformation"
  children:
    - file: Part3-Geodynamics/Elasticity/module1-fundamentals.md
    - file: Part3-Geodynamics/Elasticity/module2-applications.md
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
# Live preview
pixi run start

# Full build: reports broken links and missing files
pixi run build
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

### Custom Icons

Add icons to sections (requires custom HTML):

```yaml
- title: "🔥 Theme 1: Heat Conduction"
- title: "🌊 Theme 2: Mantle Convection"
- title: "⚗️ Theme 3: Stokes Flow"
```

## Minimal Example

Minimal `myst.yml` table of contents to test three-level navigation:

```yaml
project:
  toc:
    - file: index.md
    - title: "Test Part"
      children:
        - title: "Test Section"
          children:
            - file: chapter1.md
            - file: chapter2.md
            - file: chapter3.md
```

## Summary

**Key Recommendations:**
1. Use three-level hierarchy: Parts → Sections → Modules
2. Keep the `toc` nesting to parts → sections → modules so the sidebar stays readable
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