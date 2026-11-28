// Flow around a bluff body (inviscid-flows, fig-stagnation).
// Potential-flow streamlines past a cylinder (stagnation-point.py). The
// dividing streamline runs along the axis and ends at the stagnation point S
// on the front of the body, where the velocity is zero and the pressure is
// p_stag = p_0 + rho U_0^2 / 2. Far upstream the stream has speed U_0 and
// pressure p_0.
// Single column (90 mm).
//
// Build:  pixi run figures stagnation-point   (runs stagnation-point.py first)

#import "../primerfig.typ": *
#show: fig-setup
#let data = json("stagnation-point.json")

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let s = 11                        // mm per cylinder radius
  let P(p) = (p.at(0) * s, p.at(1) * s)
  for l in data.lines { line(..l.map(P), stroke: s-construct) }
  // dividing streamline and the body
  line(P((-4, 0)), P((-1, 0)), stroke: s-interface)
  line(P((1, 0)), P((3, 0)), stroke: s-interface)
  circle((0, 0), radius: s, fill: solid-tint, stroke: s-boundary)
  // free stream
  for yy in (-1.8, -0.9, 0.9, 1.8) {
    line(P((-4.3, yy)), P((-3.3, yy)), ..a-velocity)
  }
  content(P((-3.8, 2.25)), anchor: "south", [$U_0$, $p_0$])
  // stagnation point
  circle(P((-1, 0)), radius: 1.1, fill: ink, stroke: none)
  content((-s - 2, -2), anchor: "north-east", $S$)
  content((-s - 2, 2.2), anchor: "south-east", $p_"stag"$)
})
