// Anderson's classes of fault (stress-and-faulting, fig-anderson-faults).
// With phi = 30 degrees faults form at 45 - phi/2 = 30 degrees to sigma_1, in
// conjugate pairs. (a) Normal: sigma_1 vertical, faults dip 60. (b) Thrust:
// sigma_1 horizontal, sigma_3 vertical, faults dip 30. (c) Strike-slip, map
// view: sigma_1 and sigma_3 horizontal, vertical faults striking 30 degrees
// either side of sigma_1. Force arrows: principal stresses (compression in).
// Double column (183 mm).
//
// Build:  pixi run figures anderson-faults

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let W = 40
  let H = 26
  let small(pos, body, anchor: "center") = content(pos, anchor: anchor, text(7.5pt, body))
  let panel(x0, s1-vertical, plane-deg, lab, title, surface: true) = {
    rect((x0, 0), (x0 + W, H), fill: solid-tint, stroke: none)
    if surface { line((x0, H), (x0 + W, H), stroke: s-boundary) } else { rect((x0, 0), (x0 + W, H), stroke: s-interface) }
    // conjugate faults through the centre, at plane-deg either side of sigma_1
    let c = (x0 + W / 2, H / 2)
    for sgn in (1, -1) {
      // direction of the fault trace: at plane-deg from sigma_1
      let a = if s1-vertical { 90deg + sgn * plane-deg * 1deg } else { sgn * plane-deg * 1deg }
      let L = if s1-vertical { 13 } else { 20 }
      let d = (calc.cos(a), calc.sin(a))
      line((c.at(0) - L * d.at(0), c.at(1) - L * d.at(1)), (c.at(0) + L * d.at(0), c.at(1) + L * d.at(1)),
           stroke: if sgn == 1 { s-boundary } else { (paint: ink, thickness: w-boundary, dash: "dashed") })
    }
    // principal stresses
    if s1-vertical {
      for x in (c.at(0) - 6, c.at(0) + 6) {
        line((x, H + 10), (x, H + 1), ..a-force)
        line((x, -10), (x, -1), ..a-force)
      }
      small((c.at(0) + 7.5, H + 8.5), $sigma_1$, anchor: "west")
      line((x0 - 6, H / 2), (x0 - 1, H / 2), stroke: (paint: force, thickness: 0.8pt), mark: (end: "stealth", fill: force, scale: 0.45))
      line((x0 + W + 6, H / 2), (x0 + W + 1, H / 2), stroke: (paint: force, thickness: 0.8pt), mark: (end: "stealth", fill: force, scale: 0.45))
      small((x0 + W + 4, H / 2 + 1.2), $sigma_3$, anchor: "south")
    } else {
      for y in (H / 2 - 5, H / 2 + 5) {
        line((x0 - 10, y), (x0 - 1, y), ..a-force)
        line((x0 + W + 10, y), (x0 + W + 1, y), ..a-force)
      }
      small((x0 - 9, H / 2 + 6.5), $sigma_1$, anchor: "south-west")
      line((c.at(0), -6), (c.at(0), -1), stroke: (paint: force, thickness: 0.8pt), mark: (end: "stealth", fill: force, scale: 0.45))
      small((c.at(0) + 1.2, -5), lab, anchor: "west")
    }
    small((c.at(0), -12), title, anchor: "north")
  }
  panel(0, true, 30, none, [(a) normal: dip 60°])
  panel(64, false, 30, $sigma_3$, [(b) thrust: dip 30°])
  panel(128, false, 30, $sigma_3$, [(c) strike-slip, map view: vertical], surface: false)
})
