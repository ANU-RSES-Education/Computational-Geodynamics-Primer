# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

The Computational Geodynamics Primer is an interactive textbook built with Quarto, featuring live Python execution via pyodide/WebAssembly. The book is designed to introduce computational methods for geodynamics.

**Built from EMSC-QuartoBook-Course template** - This repository syncs infrastructure updates from the template while protecting course-specific content.

## Source Material

The repository contains legacy content in `EatYourWords/` that is being migrated into the main book:

### EatYourWords/Geophysics/
- **Origin**: Single-author Jupyter Book material (consistent writing style)
- **Structure**: 4 parts covering:
  - Part0: Introduction
  - Part1: Fluid Dynamics (Continuum Mechanics, Navier-Stokes, Mantle Dynamics, Thermal Convection, Lithospheric Dynamics)
  - Part2: Python (numpy, scipy, matplotlib, cartopy, stripy - extensive tutorials)
  - Part3: Numerical Methods (5 chapters)
- **Format**: Markdown (.md) files, ready for conversion to .qmd
- **Status**: Ready to migrate, minimal restyling needed

### EatYourWords/latex_originals/ICFM/
- **Origin**: Incompressible Fluid Mechanics - multi-author LaTeX material
- **Format**: LaTeX source files (ICFM.tex)
- **Status**: Needs more extensive restyling due to multiple authors
- **Note**: Mine for useful content but expect significant rework

### EatYourWords/latex_originals/ShortCourse/
- **Status**: IGNORE - artifact from previous migration attempt

## Development Workflow

### Fast Iterative Development (Recommended)
```bash
quarto preview WebBook
```
- Auto-rebuilds only changed files
- Live reload in browser
- Pyodide examples work correctly
- Use this for all content development

### Full Build (For Embedded Content)
```bash
quarto render WebBook
python serve-book.py
```
- Required when testing embedded reveal.js slides
- Required when iframe content uses relative paths
- Preview mode doesn't resolve all relative paths correctly

### Using Pixi (Package Manager)
```bash
pixi install              # Install dependencies
pixi run quarto render    # Run quarto via pixi
```

## Architecture

### Book Structure (`WebBook/_quarto.yml`)
- **Format**: `live-html` with pyodide integration
- **Theme**: Cosmo base + custom SCSS (`assets/theme.scss`) + CSS (`assets/styles.css`)
- **Execute**: `enabled: false` - pyodide handles interactive code
- **Output**: `_build/book/` (not committed)

### Content Organization
- `WebBook/*.qmd` - Main book chapters
- `WebBook/LectureSlides/` - Embedded reveal.js presentations
- `WebBook/Notebooks/` - Jupyter notebooks and interactive examples
- `WebBook/Images/` - Course-specific images
- `WebBook/Diagrams/` - Imported from EatYourWords (when migrated)
- `WebBook/assets/` - Theme files, logos, styling

### Template Synchronization System
The repository uses `.templatesyncignore` to protect content during template syncs:

**Protected (course-specific)**:
- `WebBook/_quarto.yml` - Book configuration
- `WebBook/*.qmd` - All content files
- `WebBook/LectureSlides/**` - Slides
- `WebBook/Notebooks/**` - Interactive content
- `WebBook/Images/**` - Images
- `README.md` - Course documentation

**Synced (infrastructure)**:
- `WebBook/assets/theme.scss` - Base theme
- `WebBook/assets/styles.css` - Additional styling
- `.github/workflows/` - CI/CD
- `update-template.sh` - Update script
- `pixi.toml`, `pixi.lock` - Dependencies
- `serve-book.py` - Preview server

### Update Template Script
```bash
./update-template.sh
```
Checks for:
1. Quarto extension updates
2. Python package updates via pixi
3. Template repository changes
4. JupyterLite rebuild needs

## Code Execution Model

**Pyodide (Browser-based Python)**:
- Runs Python directly in the browser via WebAssembly
- No server required for code execution
- Available packages listed in `_quarto.yml` under `pyodide.packages`
- Use `{pyodide}` code blocks for interactive execution
- Use `{python}` code blocks for display-only

**Binder Integration**:
- Available for complex analyses requiring full Python environment
- Configuration in `.binder/` directory

**JupyterLite**:
- Full Jupyter environment in browser
- Configuration in `jupyterlite/` directory
- Rebuilds via `update-template.sh` when content changes

## Migrating Legacy Content

When importing from `EatYourWords/Geophysics/`:

1. **Create holding area**: Add a "Draft Material" part to `_quarto.yml` to avoid dominating the book structure
2. **Markdown → QMD**: Rename `.md` → `.qmd` (Quarto markdown is backward compatible)
3. **Copy to WebBook**: Place in subdirectory like `WebBook/DraftMaterial/`
4. **Handle diagrams**: Copy referenced diagrams from `EatYourWords/Geophysics/Diagrams/` to `WebBook/Images/`
5. **Update image paths**: Adjust relative paths in content
6. **Test pyodide**: Verify any Python code blocks work with browser-based execution
7. **Reorganize later**: Once full book structure is defined, redistribute content appropriately

Example _quarto.yml structure for draft content:
```yaml
- part: "**Draft Material** (Being reorganized)"
  chapters:
    - DraftMaterial/FluidDynamics.qmd
    - DraftMaterial/NumericalMethods.qmd
```

## Deployment

- **GitHub Actions**: Automatic build and deploy on push to main
- **Output**: GitHub Pages at `https://ANU-RSES-Education.github.io/Computational-Geodynamics-Primer/book`
- **Workflow**: `.github/workflows/` (synced from template)

## Python Code Blocks

**Interactive (executable in browser)**:
```markdown
\`\`\`{pyodide}
import numpy as np
print(np.arange(10))
\`\`\`
```

**Display only**:
```markdown
\`\`\`{python}
# This code is shown but not executed
\`\`\`
```

## Theme Customization

- **Colors**: ANU gold `#C58812` for links, navbar background
- **Navbar**: Gold background, white text, ANU logo (PNG)
- **Sidebar**: Docked style, light background, earthquake image logo
- **Typography**: Cosmo theme base with custom adjustments in `theme.scss`

## Common Pitfalls

1. **Preview mode breaks embedded slides**: Use full render + serve-book.py instead
2. **Image paths**: Relative to the `.qmd` file, not the project root
3. **Pyodide limitations**: Not all Python packages available - check `_quarto.yml` pyodide.packages
4. **Template sync conflicts**: Content files are protected by `.templatesyncignore`, but verify after syncs
5. **Execute: false**: This is intentional - pyodide handles execution, not Quarto's knitr/jupyter engines
