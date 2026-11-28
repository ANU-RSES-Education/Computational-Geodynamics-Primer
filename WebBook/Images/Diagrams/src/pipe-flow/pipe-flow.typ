// Poiseuille flow in a circular pipe (analytical-solutions, fig-pipe-flow).
// Axial section of a pipe of radius a, axis z: the axial velocity
// w(r) = gamma a^2 (1 - r^2/a^2) / (4 mu) is a paraboloid; the cross-section
// on the right shows the same profile is the same at every angle.
// Single column (90 mm).
//
// Build:  pixi run figures pipe-flow

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let L = 50
  let a = 11
  let W = 16                         // peak speed drawn, mm
  rect((0, -a), (L, a), fill: fluid-tint, stroke: none)
  for (y, d) in ((-a, -1), (a, 1)) {
    line((0, y), (L, y), stroke: s-boundary)
    for k in range(21) { line((1 + k * 2.5, y), (-0.8 + k * 2.5, y + d * 1.8), stroke: s-construct) }
  }
  line((-3, 0), (L + 5, 0), stroke: (paint: ink, thickness: w-construct, dash: "dash-dotted"))
  content((L + 5.5, 0), anchor: "west", $z$)
  let w(r) = W * (1 - r * r / (a * a))
  let x0 = 14
  line((x0, -a), (x0, a), stroke: s-construct)
  for j in range(-4, 5) {
    let r = j * a / 5
    if j != 0 or true { line((x0, r), (x0 + w(r), r), ..a-velocity) }
  }
  line(..range(0, 41).map(j => { let r = -a + j * 2 * a / 40; (x0 + w(r), r) }), stroke: (paint: velocity, thickness: w-construct))
  content((x0 + W + 1.5, 3), anchor: "west", $w(r)$)
  line((x0 - 4, 0), (x0 - 4, a), ..a-dimension)
  content((x0 - 5, a / 2), anchor: "east", $a$)
  // cross-section
  let cx = L + 20
  circle((cx, 0), radius: a, fill: fluid-tint, stroke: s-boundary)
  for k in range(1, 4) { circle((cx, 0), radius: k * a / 4, stroke: (paint: velocity, thickness: w-construct, dash: "dotted")) }
  line((cx, 0), (cx + a * 0.71, a * 0.71), stroke: s-construct)
  content((cx + a * 0.36 + 1, a * 0.36 - 1), anchor: "north-west", $r$)
  circle((cx, 0), radius: 0.7, fill: ink, stroke: none)
})
