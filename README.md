# Computational Geodynamics Primer

An open textbook on the physics of the Earth's interior and the numerical
methods used to model it: fluid dynamics, mantle convection, tectonics and the
finite element method.

[Read the book online](https://anu-rses-education.github.io/Computational-Geodynamics-Primer/book/)

The book is written in [MyST markdown](https://mystmd.org) and built with
mystmd, using the same toolchain as the
[Underworld Technical Notes](https://github.com/Underworld-Technical-Notes/underworldcode.org).

## Building locally

Install [pixi](https://pixi.sh), then:

```bash
pixi install          # once: pinned mystmd, Typst, Python
pixi run start        # live preview at http://localhost:3000
pixi run build        # static site in WebBook/_build/html
pixi run figures      # rebuild figures from WebBook/Images/Diagrams/src/
```

The table of contents, maths macros and site options are in
`WebBook/myst.yml`. Pushes to `main` are built and published by
`.github/workflows/publish.yml`.

## Contributing

Writing, markup and accessibility guidance is in `WebBook/GoverningDocuments/`.
Figures follow the Underworld line-diagram house style; see
`WebBook/Images/Diagrams/src/README.md`.

## License

CC0 1.0 Universal (public domain dedication); see [LICENSE](LICENSE).

## Acknowledgments

Developed at the Research School of Earth Sciences,
[Australian National University](https://earthsciences.anu.edu.au/).
