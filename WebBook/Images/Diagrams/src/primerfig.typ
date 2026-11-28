// Figure style tokens for the Computational Geodynamics Primer.
//
// Values follow the Underworld line-diagram house style
// (underworld3: docs/developer/guides/uw-line-diagrams.md). They are
// declared here rather than imported so the book builds on its own.
// Use the tokens; do not restyle figures locally.
//
// Rules in brief: line weight and dash carry meaning, colour is secondary,
// so every figure must read in grayscale. Draw the condition rather than
// describe it, no caption text in the figure, direct labels rather than
// legends, design at final width (90 mm single, 183 mm double column).

#import "@preview/cetz:0.3.4"

// --- themes -------------------------------------------------------------
// Every figure compiles twice from one source:
//   typst compile ... NAME.typ NAME.svg                        (light)
//   typst compile --input theme=dark ... NAME.typ NAME-dark.svg (blueprint)
// Only colours change between themes; line weights and dashes do not, so the
// grayscale rule holds in both. In the blueprint theme the physical colours
// keep their hues but are pale enough to read on the blue ground.
#let theme-name = sys.inputs.at("theme", default: "light")
#let themes = (
  light: (
    paper:      rgb("#ffffff"),
    ink:        rgb("#1f2a33"),   // walls, text, dimensions
    mesh-grey:  rgb("#9aa3aa"),   // mesh / grid edges
    velocity:   rgb("#1b6f6a"),   // teal
    force:      rgb("#a1522a"),   // rust
    energy:     rgb("#6b3d8f"),   // plum: heat / energy / flux
    fluid-tint: rgb("#eef3f6"),
    solid-tint: rgb("#e4e0da"),
    material-a: rgb("#3a6ea5"),   // blue
    material-b: rgb("#4f8f46"),   // green
    emphasis:   rgb("#1f2a33").transparentize(85%),
    accent:     rgb("#b23a6e"),   // raspberry
  ),
  dark: (
    paper:      rgb("#2d5277"),   // washed-out blueprint blue
    ink:        rgb("#f1f5f9"),
    mesh-grey:  rgb("#8fa9c3"),
    velocity:   rgb("#8fe6e0"),   // pale cyan
    force:      rgb("#f6b98f"),   // warm peach
    energy:     rgb("#d4b5f5"),   // lilac
    fluid-tint: rgb("#38618a"),   // a little lighter than the ground
    solid-tint: rgb("#234466"),   // a little darker than the ground
    material-a: rgb("#a9d2ff"),   // pale blue
    material-b: rgb("#b9e6a5"),   // pale green
    emphasis:   rgb("#ffffff").transparentize(84%),
    accent:     rgb("#ff9fca"),   // pale raspberry
  ),
)
#let T = themes.at(theme-name)

// --- colour roles -------------------------------------------------------
#let paper      = T.paper
#let ink        = T.ink
#let mesh-grey  = T.mesh-grey
#let velocity   = T.velocity
#let force      = T.force
#let energy     = T.energy
#let fluid-tint = T.fluid-tint
#let solid-tint = T.solid-tint
// Two materials (e.g. particles of different composition). The pair is close
// in lightness, so always pair the colours with different marker shapes.
#let material-a = T.material-a
#let material-b = T.material-b
// Neutral emphasis with no physical meaning (support regions, highlights).
#let emphasis-tint = T.emphasis
// Accent for non-physical emphasis (a highlighted line, region or label).
// Chosen on visual grounds: its hue is clear of velocity, force and energy.
#let accent = T.accent

// --- line weights at final size -----------------------------------------
#let w-boundary = 1.2pt   // physical boundary
#let w-interface = 0.8pt  // interface, hidden line, control volume
#let w-construct = 0.5pt  // streamlines, construction
#let w-mesh = 0.25pt      // mesh edges, drawn under the boundary

#let s-boundary  = (paint: ink, thickness: w-boundary)
#let s-interface = (paint: ink, thickness: w-interface)
#let s-hidden    = (paint: ink, thickness: w-interface, dash: "dashed")
#let s-construct = (paint: ink, thickness: w-construct)
#let s-mesh      = (paint: mesh-grey, thickness: w-mesh)

// --- arrow classes: one per quantity -------------------------------------
#let a-velocity  = (stroke: (paint: velocity, thickness: 0.9pt), mark: (end: "stealth", fill: velocity, scale: 0.6))
#let a-force     = (stroke: (paint: force, thickness: 1.3pt), mark: (end: "stealth", fill: force, scale: 0.7))
#let a-energy    = (stroke: (paint: energy, thickness: 1.1pt), mark: (end: "stealth", fill: energy, scale: 0.6))
#let a-dimension = (stroke: (paint: ink, thickness: 0.5pt), mark: (start: "stealth", end: "stealth", fill: ink, scale: 0.4))

// --- page and text --------------------------------------------------------
#let fig-setup(body) = {
  set page(width: auto, height: auto, margin: 1mm, fill: paper)
  set text(font: ("Helvetica", "Arial"), size: 8pt, fill: ink)
  body
}

// Label with a light backing so it reads over mesh lines.
// (Inlined form: uwfig.typ's label() panics under CeTZ 0.3.4.)
#let flabel(pos, body, anchor: "center") = cetz.draw.content(
  pos, anchor: anchor,
  box(fill: paper.transparentize(15%), inset: 1.5pt, radius: 1.5pt, text(8pt, fill: ink, body)),
)
