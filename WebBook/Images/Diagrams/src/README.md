# Figure sources

Every redrawn figure in `Images/Diagrams/` has its source here, one folder per
figure, and one command rebuilds them all:

```bash
pixi run figures
```

- Schematics: Typst + CeTZ 0.3.4, using the tokens in `primerfig.typ`.
  Typst is pinned in `pixi.toml` (0.13.*).
- Computed geometry (meshes, curves from data): matplotlib (to be added).

Style follows the Underworld line-diagram house style
(`underworld3/docs/developer/guides/uw-line-diagrams.md`). In brief: line
weight and dash carry the meaning and colour is secondary, so every figure
must read in grayscale; draw the condition rather than describe it; no
caption text in the figure; direct labels, not legends; design at final width
(90 mm single, 183 mm double column).

Output: SVG for the web book, plus a 300 dpi PNG. Typst's SVG output
converts text to outlines, so the SVG text is not selectable.
