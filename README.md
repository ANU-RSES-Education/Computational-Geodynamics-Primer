# Computational Geodynamics Primer

An interactive textbook introducing computational methods for geodynamics. Built with Quarto and featuring live Python examples powered by pyodide.

## Features

- **Quarto Book** - Beautiful, searchable course notes with live Python execution
- **Reveal.js Slides** - Professional presentation slides embedded in your course
- **JupyterLite** - Full Jupyter environment running in the browser
- **Pyodide Integration** - Run Python code directly in web pages
- **Binder Integration** - Full-featured computing environment for complex analyses
- **Automated Deployment** - Push to deploy via GitHub Actions
- **Template Sync** - Automatically receive updates and improvements

## Online Version

[![Computational Geodynamics Primer](https://img.shields.io/badge/Primer-Book-orange)](https://ANU-RSES-Education.github.io/Computational-Geodynamics-Primer/book)

[View the book online](https://anu-rses-education.github.io/Computational-Geodynamics-Primer/book/)

## Local Development

### Install Dependencies

Using [Pixi](https://prefix.dev/docs/pixi/overview) (recommended):

```bash
pixi install
pixi run quarto render WebBook
```

Or with Python/pip:

```bash
# Install Quarto from https://quarto.org
pip install jupyterlite jupyterlite-pyodide-kernel ipython ipykernel
quarto render WebBook
```

### Preview Locally

**For development (recommended):**

Use Quarto's preview mode for auto-rebuilding and live reload:

```bash
quarto preview WebBook
```

This will:
- Only rebuild changed files (much faster than full rebuild)
- Auto-rebuild when you save changes
- Serve the book and open your browser
- Support live Python examples via pyodide

Press `Ctrl+C` to stop.

**For viewing a built book:**

Use `quarto render WebBook` to preview your writing, followed by:

```bash
python serve-book.py
```

This starts a local HTTP server (auto-selecting an available port from 8000+) and opens your browser.

**Note:** If your book includes embedded slides or iframes with relative paths to other built content, use this method instead of `quarto preview`, as preview mode may not resolve all relative paths correctly.

## About

Built using the [EMSC Quarto Course Template](https://github.com/ANU-RSES-Education/EMSC-QuartoBook-Course), developed by the Research School of Earth Sciences (RSES) at the Australian National University

## License

MIT License - see [LICENSE](LICENSE) for details.

## Acknowledgments

Developed by the Research School of Earth Sciences (RSES) at the [Australian National University](https://earthsciences.anu.edu.au/).
