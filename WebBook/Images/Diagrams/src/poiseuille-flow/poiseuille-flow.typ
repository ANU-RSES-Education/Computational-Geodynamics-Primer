// Plane Poiseuille flow (analytical-solutions, fig-poiseuille).
// Both plates fixed; a uniform pressure gradient dp/dx = -gamma drives the flow
// (p_1 > p_2): u(z) = gamma z (h - z) / (2 mu).
// Single column (90 mm).
//
// Build:  pixi run figures poiseuille-flow

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let L = 56
  let h = 22
  let U = 16                         // peak speed drawn, mm
  rect((0, 0), (L, h), fill: fluid-tint, stroke: none)
  for (y, d) in ((0, -1), (h, 1)) {
    line((0, y), (L, y), stroke: s-boundary)
    for k in range(23) { line((1 + k * 2.5, y), (-0.8 + k * 2.5, y + d * 1.8), stroke: s-construct) }
  }
  let u(z) = 4 * U * z * (h - z) / (h * h)
  let x0 = 18
  line((x0, 0), (x0, h), stroke: s-construct)
  for j in range(1, 8) {
    let z = j * h / 8
    line((x0, z), (x0 + u(z), z), ..a-velocity)
  }
  line(..range(0, 41).map(j => { let z = j * h / 40; (x0 + u(z), z) }), stroke: (paint: velocity, thickness: w-construct))
  content((x0 + U + 1.5, h / 2), anchor: "west", $u(z)$)
  content((-2, h / 2), anchor: "east", $p_1$)
  content((L + 2, h / 2), anchor: "west", $p_2 < p_1$)
  line((L + 4, 0), (L + 4, 6), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  content((L + 4, -1), anchor: "north", $z$)
  line((x0 - 5, 0), (x0 - 5, h), ..a-dimension)
  content((x0 - 6, h * 0.3), anchor: "east", $h$)
})
