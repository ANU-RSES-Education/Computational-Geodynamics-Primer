// Book logo: a sphere with an icosahedral computational grid, continents drawn
// over it (geometry from primer-logo.py). Transparent ground, so it sits on the
// site header in either theme; colours from the theme tokens.
//
// Build:  pixi run figures primer-logo   (runs primer-logo.py first)

#import "../primerfig.typ": *
#set page(width: auto, height: auto, margin: 0.6mm, fill: none)
#let data = json("primer-logo.json")

#cetz.canvas(length: 1mm, {
  import cetz.draw: *
  let r = 14                                   // sphere radius, mm
  let P(p) = (p.at(0) * r, p.at(1) * r)
  // grid
  for e in data.grid {
    line(..e.map(P), stroke: (paint: mesh-grey, thickness: 0.35pt))
  }
  // continents over the grid: a light fill lets the grid show through
  for c in data.coasts {
    line(..c.map(P), close: true, fill: ink.transparentize(78%),
         stroke: (paint: ink, thickness: 0.7pt, join: "round"))
  }
  // the limb
  circle((0, 0), radius: r, stroke: (paint: ink, thickness: 1.1pt))
})
