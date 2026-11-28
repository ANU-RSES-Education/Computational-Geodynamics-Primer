// A fluid layer heated from below (nondimensional-equations, fig-layer).
// Depth d, temperature 0 on the upper boundary and Delta T on the lower one.
// The flow (one circulating cell) carries heat upward; Q leaves through the top.
// Single column (90 mm).
//
// Build:  pixi run figures convection-layer

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let W = 64
  let d = 24
  rect((0, 0), (W, d), fill: fluid-tint, stroke: none)
  line((-2, d), (W + 2, d), stroke: s-boundary)
  line((-2, 0), (W + 2, 0), stroke: s-boundary)
  content((W + 3, d), anchor: "west", $T = 0$)
  content((W + 3, 0), anchor: "west", $T = Delta T$)

  // one convection cell: hot fluid rises on the left, sinks on the right
  let c = (26, d / 2)
  circle(c, radius: (15, 7.5), stroke: (paint: velocity, thickness: 0.9pt))
  for (p, q) in (((c.at(0) - 2, c.at(1) + 7.5), (c.at(0) + 2, c.at(1) + 7.5)),
                 ((c.at(0) + 2, c.at(1) - 7.5), (c.at(0) - 2, c.at(1) - 7.5))) {
    line(p, q, ..a-velocity)
  }

  // heat leaving through the top
  for x in (50, 56) {
    line((x, d - 6), (x, d + 8), ..a-energy)
  }
  content((53, d + 8.5), anchor: "south", $Q$)

  // depth
  line((-5, 0), (-5, d), ..a-dimension)
  content((-6, d / 2), anchor: "east", $d$)
})
