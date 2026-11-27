# CLAUDE.md

Guidance for Claude Code in this repository.

## Project

The *Computational Geodynamics Primer* is an open textbook on the physics of
the Earth's interior and the numerical methods used to model it. It is written
in MyST markdown and built with mystmd, following the Underworld Technical
Notes (`underworld-technical-notes`, same toolchain and house styles).

The current iteration is a demonstration of the intended book: a few strong
chapters (numerics/finite elements first), placeholders elsewhere.

## Commands

Everything runs through pixi, so tool versions are pinned and nothing global is
needed. Never call a globally installed `myst`, `typst` or `python` instead.

```bash
pixi install          # once
pixi run start        # live preview at http://localhost:3000
pixi run build        # static site in WebBook/_build/html
pixi run figures      # rebuild every figure from Images/Diagrams/src/
```

New tools go into `pixi.toml` (with a version range) and `pixi.lock` is
committed with them.

mystmd (`pixi.toml`) and the book theme (`site.template` in `WebBook/myst.yml`)
are pinned together, as in UWTN: upgrade both at once.

## Layout

```
WebBook/
  myst.yml                  table of contents, maths macros, site options
  static/primer.css         site styling (adapted from UWTN's uwtn.css)
  index.md                  landing page
  Part1-Fundamentals/       Part I    (placeholder)
  Part2-FluidDynamics/      Part II
  Part3-Geodynamics/        Part III  (placeholder; tectonics + convection planned)
  Part4-NumericalMethods/   Part IV   numerics and finite elements
  Part5-Computational/      Part V    benchmarks
  DraftMaterial/            migrated drafts waiting to be placed
  Images/Diagrams/          figures; sources in Images/Diagrams/src/
  GoverningDocuments/       writing, markup and accessibility guides (not built)
EatYourWords/               legacy source material (read-only; see below)
jupyterlite/                JupyterLite site (separate workflow)
```

## URLs come from file names

MyST publishes `Part4-NumericalMethods/fem-introduction.md` at
`/fem-introduction`: the directory is ignored. Consequences:

- File names must be unique across the book.
- Part IV pages (`numerical-methods`, `time-integration`, `survey-of-methods`,
  `fem-introduction`, `fem-practice`, `solvers`) are cited from outside the
  book. Do not rename them.
- A new page is invisible until it is added to `toc` in `WebBook/myst.yml`.

## Writing MyST

- Figures: `:::{figure} ../Images/Diagrams/name.svg` with `:label: fig-name`,
  `:alt:` text, and the caption as the body.
- Equations to be referenced: a `` ```{math} `` block with `:label: eq-name`.
  Unlabelled display maths uses `$$ … $$`.
- Cross-references: `[](#fig-name)`, `[](#eq-name)`, `[](#tbl-name)`; section
  targets are `(sec-name)=` on the line above the heading.
- Citations: `@key` or `[@key]`, keys in `WebBook/references.bib` or
  `geodynamics-references.bib`.
- Admonitions: `:::{note} Title`; add `:class: dropdown` to collapse (used for
  worked solutions).
- Maths is rendered by KaTeX. Macros (`\uv`, `\DIV`, `\GRAD`, `\curly`, …) are
  defined once in `WebBook/myst.yml`; do not define them per page. KaTeX has no
  `eqnarray`, `\intertext` or `\textcolor[rgb]`: use `aligned`/`array`,
  `\text{…}` and named colours.

## Figures

Figures follow the Underworld line-diagram house style (underworld3:
`docs/developer/guides/uw-line-diagrams.md`). Tokens are in
`WebBook/Images/Diagrams/src/primerfig.typ`; use them rather than restyling.

- Line weight and dash carry the meaning, so every figure must read in
  grayscale; colour is secondary and each colour has a physical role.
- Draw the condition, no caption text inside the figure, direct labels rather
  than legends, design at final width (90 mm single, 183 mm double column).
- Schematics: Typst + CeTZ in `src/<name>/<name>.typ` →
  `pixi run figures` writes `<name>.svg` and a 300 dpi PNG.
- Sources are committed beside their outputs.

## Writing

Louis rewrites all prose; drafts should get the structure and the technical
content right so he can edit locally without restructuring. Follow
`WebBook/GoverningDocuments/WritingStyleGuide.md` and the voice rules in UWTN's
`CONTRIBUTING.md` ("How the notes read"): start from the question, "we" for
shared reasoning, describe objects literally, no rhetorical contrasts or
announcing phrases, stop when the question is answered. The UWTN phrase
checker runs on any file, given a path relative to the current directory:

```bash
pixi run python -I ~/+Underworld/underworld-technical-notes/scripts/check_style.py WebBook/Part4-NumericalMethods/fem-introduction.md
```

## Source material and copyright

Use only material already in this repository unless Louis grants an exception
for a specific source. Documents elsewhere are often co-authored.

- `EatYourWords/Geophysics/` — Louis's single-author Jupyter Book; the origin of
  most drafts. Migration status in `EatYourWords/MIGRATION_STATUS.md`.
- `EatYourWords/latex_originals/ICFM/` — multi-author Monash fluid mechanics
  notes, substantially rewritten by Louis. Usable, but text must be redrafted
  and every figure redrawn. Overlap analysis in `ICFM-Review.md`.
- Granted exceptions: the Mohr-circle derivation in Louis's EMSC3002 lecture
  notes (his text only; embedded third-party figures excluded); `.svg` files in
  EMSC3002 are © Romain Beucher, CC BY 4.0, usable with credit.

## Git and deployment

- Work on branches and open pull requests; ask before pushing to `main`.
- `.github/workflows/publish.yml` builds with pixi and deploys
  `WebBook/_build/html` to `gh-pages/book`, i.e.
  https://anu-rses-education.github.io/Computational-Geodynamics-Primer/book/
  (`keep_files` leaves the JupyterLite site on the same branch in place).
- The repository no longer syncs from the EMSC-QuartoBook-Course template.

## Planning

Planning notes for this project live in Louis's Box planning folder
(`Planning/textbook.md`). At the end of a working session, summarise what was
done, what is blocked, and suggested next steps.
