// Restoring force on a displaced interface (stokes-flow-applications,
// fig-rayleigh-taylor-2). Lighter fluid rho_1 above denser fluid rho_2 (stable).
// Where the interface is raised by w, a column of width delta x holds denser
// fluid above y = 0 (hatched); its excess weight F = delta x g w (rho_2 - rho_1)
// pushes the interface back down.
// Single column (90 mm).
//
// Build:  pixi run figures rt-restoring-force

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let X = 76
  let H = 13
  let w0 = 4
  let f(x) = w0 * calc.cos(2 * calc.pi * (x - 52) / 58)
  let iface = range(0, 101).map(k => { let x = k * X / 100; (x, f(x)) })
  rect((0, 0), (X, H), fill: fluid-tint, stroke: none)
  rect((0, -H), (X, 0), fill: solid-tint, stroke: none)
  line((0, -H), ..iface, (X, -H), close: true, fill: solid-tint, stroke: none)
  line(..iface, stroke: s-interface)
  line((0, 0), (X, 0), stroke: (paint: ink, thickness: w-construct, dash: "dashed"))
  line((0, H), (0, -H), (X, -H), (X, H), close: true, stroke: s-boundary)

  // the column
  let x1 = 49
  let x2 = 55
  line((x1, H), (x1, -H), stroke: s-hidden)
  line((x2, H), (x2, -H), stroke: s-hidden)
  // excess-density region: between y = 0 and the raised interface, in the column
  let top = range(0, 11).map(k => { let x = x1 + k * (x2 - x1) / 10; (x, f(x)) })
  line((x1, 0), ..top, (x2, 0), close: true, stroke: none,
       fill: tiling(size: (4pt, 4pt), std.line(start: (0pt, 4pt), end: (4pt, 0pt), stroke: 0.5pt + ink)))
  line(((x1 + x2) / 2, w0 + 7), ((x1 + x2) / 2, 1), ..a-force)
  content(((x1 + x2) / 2 - 1.5, w0 + 6), anchor: "east", $F$)
  line((x1, -H - 3), (x2, -H - 3), ..a-dimension)
  content(((x1 + x2) / 2, -H - 4), anchor: "north", $delta x$)

  content((14, H / 2), $rho_1$)
  content((14, -H / 2), $rho_2$)
  content((X + 2, 0), anchor: "west", $y = 0$)
  line((x2 + 3, 0), (x2 + 3, f(x2 + 3)), stroke: (paint: ink, thickness: 0.5pt), mark: (end: "stealth", fill: ink, scale: 0.35))
  content((x2 + 4, f(x2 + 3) / 2), anchor: "west", $w$)
})
