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

Because the book uses pyodide for interactive Python examples, you need to serve it over HTTP (not just open HTML files):

```bash
python serve-book.py
```

This will:
- Start a local HTTP server (default port 8000)
- Automatically open your browser to view the book
- Auto-select an available port if 8000 is in use

Press `Ctrl+C` to stop the server.

## About

Built using the [EMSC Quarto Course Template](https://github.com/ANU-RSES-Education/EMSC-QuartoBook-Course), developed by the Research School of Earth Sciences (RSES) at the Australian National University

## License

MIT License - see [LICENSE](LICENSE) for details.

## Acknowledgments

Developed by the Research School of Earth Sciences (RSES) at the [Australian National University](https://earthsciences.anu.edu.au/).
