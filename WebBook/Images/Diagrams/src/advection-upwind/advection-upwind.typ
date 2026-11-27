// Advection of a step on a fixed grid (survey-of-methods, fig-advection2).
// Top: phi at t = 0, a step between nodes i and i+1, carried by a uniform
//      velocity v. Bottom: after two upwind steps of Delta t = delta x / 2v,
//      the computed profile (filled) has spread over three intervals while the
//      exact solution (dashed) is the same step moved one node downstream.
// Nodal values are those of the hand calculation (tbl-hand-rolled-advection).
// Single column (90 mm).
//
// Build:  pixi run figures advection-upwind

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let dx = 7.5
  let H = 14
  let offs = range(-4, 6)                       // node offsets from i
  let row(y0, vals, exact: none, label: none) = {
    let pts = offs.zip(vals).map(((o, v)) => ((o + 4) * dx, y0 + v * H))
    line(((0, y0)), ..pts, ((9 * dx, y0)), close: true, fill: fluid-tint, stroke: none)
    line(..pts, stroke: s-interface)
    if exact != none {
      let e = offs.zip(exact).map(((o, v)) => ((o + 4) * dx, y0 + v * H))
      line(..e, stroke: s-hidden)
    }
    line((-2, y0), (9 * dx + 2, y0), stroke: s-construct)
    for o in offs { circle(((o + 4) * dx, y0), radius: 0.8, fill: ink, stroke: none) }
    if label != none { content((9 * dx + 3, y0 + H / 2), anchor: "west", label) }
  }

  // t = 0
  let y0 = 32
  row(y0, (1, 1, 1, 1, 1, 0, 0, 0, 0, 0), label: $t = 0$)
  line((1 * dx, y0 + H / 2), (3 * dx, y0 + H / 2), ..a-velocity)
  content((2 * dx, y0 + H / 2 + 1), anchor: "south", $v$)
  for (o, lab) in ((0, $i$), (1, $i+1$)) {
    content(((o + 4) * dx, y0 - 1.5), anchor: "north", lab)
  }
  content((-3, y0 + H), anchor: "east", $phi$)

  // after two upwind steps
  let y1 = 0
  row(y1, (1, 1, 1, 1, 1, 0.75, 0.25, 0, 0, 0),
      exact: (1, 1, 1, 1, 1, 1, 0, 0, 0, 0), label: $t = delta x \/ v$)
  line((4 * dx, y1 - 3), (5 * dx, y1 - 3), ..a-dimension)
  content((4.5 * dx, y1 - 4), anchor: "north", $delta x$)
  content((-3, y1 + H), anchor: "east", $phi$)
})
