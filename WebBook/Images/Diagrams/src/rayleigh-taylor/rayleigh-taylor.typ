// Salt diapirs and the Rayleigh-Taylor problem (stokes-flow-applications,
// fig-rayleigh-taylor).
// Top row: (a) a salt layer is deposited; (b) sediments bury it, denser
// material above lighter; (c) the interface becomes unstable and perturbations
// grow; (d) the salt rises as diapirs.
// Bottom: the idealised problem. Fluid 1 (rho_1) above fluid 2 (rho_2), equal
// viscosity eta, rigid walls at y = -b and y = b (y measured downward), and an
// interface displaced by w = w_0 cos kx from y = 0.
// Double column (183 mm).
//
// Build:  pixi run figures rayleigh-taylor

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let hatch(x1, x2, y, down: true) = {
    for k in range(int((x2 - x1) / 2.4) + 1) {
      let x = x1 + k * 2.4
      line((x, y), (x - 1.8, if down { y - 1.8 } else { y + 1.8 }), stroke: s-construct)
    }
  }
  let sed = solid-tint
  let salt = fluid-tint

  // ---- top row: cartoons -----------------------------------------------------
  let w = 36
  let h = 18
  let y0 = 48
  let panel(i, body, lab) = {
    let x0 = i * (w + 9)
    group({ translate((x0, y0)); body })
    line((x0, y0), (x0 + w, y0), stroke: s-boundary)
    hatch(x0 + 1, x0 + w, y0)
    content((x0 + w / 2, y0 - 3.5), anchor: "north", lab)
  }
  let wave(n, a, s) = range(0, 61).map(k => { let x = k * w / 60; (x, s + a * calc.cos(2 * calc.pi * n * x / w)) })
  panel(0, {
    rect((0, 0), (w, 4), fill: salt, stroke: none)
    line((0, 4), (w, 4), stroke: s-interface)
  }, [(a)])
  panel(1, {
    rect((0, 0), (w, h), fill: sed, stroke: none)
    rect((0, 0), (w, 4), fill: salt, stroke: none)
    line((0, 4), (w, 4), stroke: s-interface)
  }, [(b)])
  panel(2, {
    rect((0, 0), (w, h), fill: sed, stroke: none)
    let iface = wave(2, -1.4, 5)
    line((0, 0), ..iface, (w, 0), close: true, fill: salt, stroke: none)
    line(..iface, stroke: s-interface)
  }, [(c)])
  panel(3, {
    rect((0, 0), (w, h), fill: sed, stroke: none)
    for xc in (9, 27) {
      // a diapir: a stem rising from the thinned source layer into a cap
      let stem = ((xc - 2, 1.5), (xc - 1.6, 8), (xc - 4.5, 12.5), (xc, 15), (xc + 4.5, 12.5), (xc + 1.6, 8), (xc + 2, 1.5))
      hobby(..stem, fill: salt, stroke: s-interface)
    }
    rect((0, 0), (w, 1.6), fill: salt, stroke: none)
    line((0, 1.6), (7, 1.6), stroke: s-interface)
    line((11, 1.6), (25, 1.6), stroke: s-interface)
    line((29, 1.6), (w, 1.6), stroke: s-interface)
  }, [(d)])

  // ---- bottom: the idealised problem (y increases downward) ----------------
  let X = 120
  let b = 11
  let ox = 22
  let oy = 12                           // y = 0 on the page
  let Y(y) = oy - y                     // page coordinate for depth y
  rect((ox, Y(-b)), (ox + X, Y(b)), fill: none, stroke: none)
  rect((ox, Y(0)), (ox + X, Y(-b)), fill: sed, stroke: none)
  rect((ox, Y(b)), (ox + X, Y(0)), fill: salt, stroke: none)
  let w0 = 2.6
  let iface = range(0, 121).map(k => { let x = k * X / 120; (ox + x, Y(w0 * calc.cos(2 * calc.pi * 1.5 * x / X))) })
  line((ox, Y(0)), ..iface, (ox + X, Y(0)), close: true, fill: salt, stroke: none)
  line(..iface, stroke: s-interface)
  line((ox, Y(0)), (ox + X, Y(0)), stroke: (paint: ink, thickness: w-construct, dash: "dashed"))
  for y in (-b, b) { line((ox, Y(y)), (ox + X, Y(y)), stroke: s-boundary) }
  hatch(ox + 1, ox + X, Y(b))
  hatch(ox + 1, ox + X, Y(-b), down: false)
  content((ox + 14, Y(-b / 2)), $rho_1, eta$)
  content((ox + 14, Y(b / 2)), $rho_2, eta$)
  // labels on the right
  for (y, lab) in ((-b, $y = -b$), (0, $y = 0$), (b, $y = b$)) {
    content((ox + X + 2.5, Y(y)), anchor: "west", lab)
  }
  // displacement w at a crest
  let xw = ox + 2 * X / 3
  line((xw + 3, Y(0)), (xw + 3, Y(w0)), stroke: (paint: ink, thickness: 0.5pt), mark: (end: "stealth", fill: ink, scale: 0.35))
  content((xw + 4.2, Y(w0 / 2) + 0.4), anchor: "west", $w$)
  // axes: x to the right, y downward
  line((ox - 12, Y(-b) + 2), (ox - 4, Y(-b) + 2), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  content((ox - 3.5, Y(-b) + 2), anchor: "west", $x$)
  line((ox - 12, Y(-b) + 2), (ox - 12, Y(-b) - 6), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  content((ox - 12, Y(-b) - 6.5), anchor: "north", $y$)
})
