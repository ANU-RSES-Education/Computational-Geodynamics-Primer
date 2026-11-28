// Couette flow (analytical-solutions, fig-couette).
// Lower plate z = 0 fixed, upper plate z = h moving at U, no pressure
// gradient: u(z) = U z / h.
// Single column (90 mm).
//
// Build:  pixi run figures couette-flow

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let L = 56
  let h = 22
  let U = 20
  rect((0, 0), (L, h), fill: fluid-tint, stroke: none)
  line((0, 0), (L, 0), stroke: s-boundary)
  for k in range(23) { line((1 + k * 2.5, 0), (-0.8 + k * 2.5, -1.8), stroke: s-construct) }
  rect((0, h), (L, h + 2.2), fill: solid-tint, stroke: s-boundary)
  line((L - 18, h + 4.5), (L - 4, h + 4.5), ..a-velocity)
  content((L - 3.5, h + 4.5), anchor: "west", $U$)

  let x0 = 14
  line((x0, 0), (x0, h), stroke: s-construct)
  for j in range(1, 6) {
    let z = j * h / 5
    line((x0, z), (x0 + U * z / h, z), ..a-velocity)
  }
  line((x0, 0), (x0 + U, h), stroke: (paint: velocity, thickness: w-construct))
  content((x0 + U * 0.55 + 2, h * 0.5), anchor: "west", $u(z)$)

  line((-4, 0), (-4, h), ..a-dimension)
  content((-5, h / 2), anchor: "east", $h$)
  line((L + 4, 0), (L + 4, 8), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  content((L + 4, 8.5), anchor: "south", $z$)
})
