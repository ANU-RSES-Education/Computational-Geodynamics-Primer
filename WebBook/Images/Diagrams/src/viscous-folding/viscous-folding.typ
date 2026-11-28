// Buckling of a stiff viscous layer (stokes-flow-applications, fig-folding).
// A layer of thickness h and viscosity eta_1, embedded in much weaker fluid of
// viscosity eta_0, is compressed by a stress P from both ends; its centre line
// is deflected by w.
// Single column (90 mm).
//
// Build:  pixi run figures viscous-folding

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let X = 64
  let h = 3.2
  let a = 2.6
  let k = 2 * calc.pi * 2.25 / X
  let c(x) = a * calc.sin(k * x)
  let top = range(0, 121).map(j => { let x = j * X / 120; (x, c(x) + h / 2) })
  let bot = range(0, 121).map(j => { let x = X - j * X / 120; (x, c(x) - h / 2) })
  rect((0, -14), (X, 14), fill: fluid-tint, stroke: none)
  line(..top, ..bot, close: true, fill: solid-tint, stroke: s-interface)
  line((0, 0), (X, 0), stroke: (paint: ink, thickness: w-construct, dash: "dashed"))

  // end plates and compression
  for (x, s) in ((0, 1), (X, -1)) {
    line((x, c(x) - 4.5), (x, c(x) + 4.5), stroke: (paint: ink, thickness: 2pt))
    line((x - s * 12, c(x)), (x - s * 1.5, c(x)), ..a-force)
  }
  content((-12, c(0) + 1.5), anchor: "south-west", $P$)
  content((X + 12, c(X) + 1.5), anchor: "south-east", $P$)

  content((X / 2, 10), $eta_0$)
  content((X / 2, -10), $eta_0$)
  // h and w where the layer crosses its crest
  let xc = X * 1.25 / 2.25 / 2
  content((xc + 7, c(xc) + h / 2 + 1.8), anchor: "south", $eta_1$)
  line((xc, 0), (xc, c(xc)), stroke: (paint: ink, thickness: 0.5pt), mark: (end: "stealth", fill: ink, scale: 0.35))
  content((xc - 1, c(xc) / 2), anchor: "east", $w$)
  let xt = X * 1.25 / 2.25                     // a crest of the centre line
  line((xt, c(xt) - h / 2), (xt, c(xt) + h / 2), ..a-dimension)
  content((xt + 1.2, c(xt) + h / 2 + 1), anchor: "south-west", $h$)
})
