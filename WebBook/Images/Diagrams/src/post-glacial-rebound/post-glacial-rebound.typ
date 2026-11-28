// Post-glacial rebound (stokes-flow-applications, fig-post-glacial).
// Top: an ice load holds the surface of a viscous half space in a depression.
// Below: after the ice melts the depression relaxes; mantle flows back in
// beneath it and the surface rises. Depression depth decays with time
// (1, 0.55, 0.3, 0.15 of its loaded value in the rows shown).
// Single column (90 mm).
//
// Build:  pixi run figures post-glacial-rebound

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let X = 70
  let D = 9                                // half-space depth drawn
  let A = 4                                // loaded depression depth
  let box(x) = 0.5 * (calc.tanh((x - 22) / 2.2) - calc.tanh((x - 48) / 2.2))
  let row(y0, amp, ice: false, flow: false) = {
    let surf = range(0, 141).map(k => { let x = k * X / 140; (x, y0 - amp * A * box(x)) })
    line((0, y0 - D), ..surf, (X, y0 - D), close: true, fill: solid-tint, stroke: none)
    line(..surf, stroke: s-boundary)
    if ice {
      let top = range(0, 61).map(k => { let x = 22 + k * 26 / 60; (x, y0 + 3) })
      rect((22, y0 - A + 0.2), (48, y0 + 3), fill: emphasis-tint, stroke: s-interface)
      content((35, y0 - 0.3), text(7pt, [ice]))
    }
    if flow {
      for s in (-1, 1) {
        let xa = 35 + s * 24
        bezier((xa, y0 - 3.5), (35 + s * 6, y0 - 3.2), (35 + s * 18, y0 - 8.5), (35 + s * 8, y0 - 8.5),
               stroke: (paint: velocity, thickness: 0.9pt), mark: (end: "stealth", fill: velocity, scale: 0.5))
      }
    }
  }
  row(48, 1.0, ice: true)
  row(32, 0.55, flow: true)
  row(16, 0.3, flow: true)
  row(0, 0.15)
  // time
  line((-5, 50), (-5, -6), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  content((-6, 22), anchor: "east", $t$)
})
