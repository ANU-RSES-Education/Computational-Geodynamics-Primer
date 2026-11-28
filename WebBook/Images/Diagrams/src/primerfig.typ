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

// --- colour roles -------------------------------------------------------
#let ink        = rgb("#1f2a33")  // walls, text, dimensions
#let mesh-grey  = rgb("#9aa3aa")  // mesh / grid edges
#let velocity   = rgb("#1b6f6a")  // teal
#let force      = rgb("#a1522a")  // rust
#let energy     = rgb("#6b3d8f")  // plum: heat / energy / flux
#let fluid-tint = rgb("#eef3f6")
#let solid-tint = rgb("#e4e0da")
// Two materials (e.g. particles of different composition). The pair is close
// in lightness, so always pair the colours with different marker shapes.
#let material-a = rgb("#3a6ea5")  // blue
#let material-b = rgb("#4f8f46")  // green
// Neutral emphasis with no physical meaning (support regions, highlights).
#let emphasis-tint = rgb("#1f2a33").transparentize(85%)

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
  set page(width: auto, height: auto, margin: 1mm, fill: white)
  set text(font: ("Helvetica", "Arial"), size: 8pt, fill: ink)
  body
}

// Label with a light backing so it reads over mesh lines.
// (Inlined form: uwfig.typ's label() panics under CeTZ 0.3.4.)
#let flabel(pos, body, anchor: "center") = cetz.draw.content(
  pos, anchor: anchor,
  box(fill: white.transparentize(15%), inset: 1.5pt, radius: 1.5pt, text(8pt, fill: ink, body)),
)
