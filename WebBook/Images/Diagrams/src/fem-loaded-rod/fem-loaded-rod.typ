// A rod under an end load (fem-introduction, fig-elastic-rod).
// (a) The rod is fixed at x = 0 (u = 0), supported on rollers, and loaded by
//     a force R at x = L.
// (b) An element of length dx: the axial forces sigma A at its two faces.
// Single column (90 mm).
//
// Build:  pixi run figures fem-loaded-rod

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  // ---- (a) geometry -----------------------------------------------------------
  let L = 44
  let t = 4                         // rod thickness
  // wall
  line((0, -4), (0, 12), stroke: s-boundary)
  for k in range(7) { line((0, -3 + k * 2.4), (-2.2, -5.2 + k * 2.4), stroke: s-construct) }
  // rod
  rect((0, 3), (L, 3 + t), fill: solid-tint, stroke: s-boundary)
  // rollers and ground
  for x in (9, 20, 31) { circle((x, 1.5), radius: 1.5, fill: paper, stroke: s-interface) }
  line((4, 0), (36, 0), stroke: s-boundary)
  for k in range(13) { line((5 + k * 2.5, 0), (3 + k * 2.5, -2), stroke: s-construct) }
  // end load
  line((L, 5), (L + 11, 5), ..a-force)
  content((L + 11.5, 5), anchor: "west", $R$)
  // axis
  line((0, 11), (14, 11), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  content((14.5, 11), anchor: "west", $x$)
  content((L / 2, -9), anchor: "north", [(a)])

  // ---- (b) element ------------------------------------------------------------
  let x0 = 72
  let w = 8
  let h = 12
  rect((x0, 0), (x0 + w, h), fill: solid-tint, stroke: s-boundary)
  line((x0 - 1, h / 2), (x0 - 11, h / 2), ..a-force)
  content((x0 - 11.5, h / 2 + 1.2), anchor: "south-west", $sigma A|_x$)
  line((x0 + w + 1, h / 2), (x0 + w + 11, h / 2), ..a-force)
  content((x0 + w + 11.5, h / 2 + 1.2), anchor: "south-east", $sigma A|_(x + delta x)$)
  line((x0, -2.5), (x0 + w, -2.5), ..a-dimension)
  content((x0 + w / 2, -3.5), anchor: "north", $delta x$)
  content((x0 + w / 2, -9), anchor: "north", [(b)])
})
