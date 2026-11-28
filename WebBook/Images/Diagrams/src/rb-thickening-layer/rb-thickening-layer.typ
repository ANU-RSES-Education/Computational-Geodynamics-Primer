// The upper boundary layer thickens as it travels (rayleigh-benard-
// convection, fig-boundary-layer-theory-2). Fluid leaves the upwelling at the
// interior temperature Delta T / 2 and moves along the cold top surface at
// speed v; in a frame moving with it the layer is a cooling half space of age
// x / v, so T / (Delta T / 2) = erf(z / 2 sqrt(kappa x / v)) and each isotherm
// deepens as sqrt(x). Isotherms drawn at T / (Delta T / 2) = 0.2, 0.4, 0.6,
// 0.8 (eta = erfinv of these). At the downwelling the cold layer sinks.
// Single column (90 mm).
//
// Build:  pixi run figures rb-thickening-layer

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let L = 62                           // cell width as drawn
  let H = 24                           // depth shown
  let dL = 8                           // 2 sqrt(kappa L / v), the thickness scale at the downwelling
  let small(pos, body, anchor: "center") = content(pos, anchor: anchor, text(7.5pt, body))
  let etas = (0.1791, 0.3708, 0.5951, 0.9062)   // erfinv(0.2, 0.4, 0.6, 0.8)

  rect((0, 0), (L, H), fill: fluid-tint, stroke: none)
  // the cold layer: down to the 0.8 isotherm, shaded
  let iso(eta) = range(0, 61).map(j => { let x = j * L / 60; (x, H - dL * calc.sqrt(x / L) * eta * 2) })
  line((0, H), ..iso(etas.at(3)), (L, H), close: true, fill: emphasis-tint, stroke: none)
  for (i, eta) in etas.enumerate() {
    line(..iso(eta), stroke: if i == 3 { s-interface } else { s-construct })
  }
  line((-3, H), (L + 3, H), stroke: s-boundary)
  line((0, 0), (0, H), stroke: s-hidden)
  line((L, 0), (L, H), stroke: s-hidden)

  // flow: up the left, along the top, down the right
  line((3, 2), (3, H - 6), ..a-velocity)
  line((10, H - 2), (L - 12, H - 2), ..a-velocity)
  line((L - 3, H - 12), (L - 3, 2), ..a-velocity)
  small((9, H - 2), $v$, anchor: "east")

  small((L / 2, H + 1.5), $T = 0$, anchor: "south")
  small((L / 2 - 8, 5), $T = Delta T \/ 2$)
  let xd = 0.72 * L
  small((xd + 1, H - dL * calc.sqrt(xd / L) * 2 * etas.at(3) - 1), $delta(x) prop sqrt(x)$, anchor: "north-east")
  line((0, -3), (L, -3), ..a-dimension)
  small((L / 2, -4), $d$, anchor: "north")
  line((0, H + 7), (14, H + 7), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  small((15, H + 7), $x$, anchor: "west")
})
