// Traction on a plane (stress-and-faulting, fig-traction-on-a-plane).
// Left: a square element with the stress components on its faces
// (compression positive: arrows point into the faces).
// Right: the element cut by a plane with unit normal n; the traction
// T = sigma . n on the cut and its components sigma_n (along n) and tau
// (along the plane). Values are those of the worked example:
// sigma_xx = 40, sigma_yy = 60, sigma_xy = 10 MPa, plane at 45 degrees.
// Single column (90 mm).
//
// Build:  pixi run figures stress-traction

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let a = 16                                   // element size
  let arrow(p, q) = line(p, q, ..a-force)
  let small(pos, body, anchor: "center") = content(pos, anchor: anchor, text(7pt, body))

  // ---- left: the element ------------------------------------------------------
  rect((0, 0), (a, a), fill: solid-tint, stroke: s-boundary)
  // normal stresses, pushing into the faces
  arrow((-9, a / 2), (-1, a / 2)); arrow((a + 9, a / 2), (a + 1, a / 2))
  arrow((a / 2, a + 9), (a / 2, a + 1)); arrow((a / 2, -9), (a / 2, -1))
  small((-9, a / 2 + 1.5), $sigma_(x x)$, anchor: "south-west")
  small((a / 2 + 1.2, a + 8.5), $sigma_(y y)$, anchor: "west")
  // shear stresses, along the faces
  let sh = (paint: force, thickness: 0.9pt)
  line((a + 1.5, 3), (a + 1.5, a - 3), stroke: sh, mark: (end: "stealth", fill: force, scale: 0.45))
  line((-1.5, a - 3), (-1.5, 3), stroke: sh, mark: (end: "stealth", fill: force, scale: 0.45))
  line((3, a + 1.5), (a - 3, a + 1.5), stroke: sh, mark: (end: "stealth", fill: force, scale: 0.45))
  line((a - 3, -1.5), (3, -1.5), stroke: sh, mark: (end: "stealth", fill: force, scale: 0.45))
  small((a + 2.5, a - 3), $sigma_(x y)$, anchor: "west")

  // ---- right: the cut ------------------------------------------------------------
  let o = (44, 0)
  let b = 20
  // triangular wedge below a 45 degree cut
  line(o, (o.at(0) + b, o.at(1)), (o.at(0), o.at(1) + b), close: true, fill: solid-tint, stroke: s-boundary)
  let m = (o.at(0) + b / 2, o.at(1) + b / 2)           // midpoint of the cut
  let n = (calc.sqrt(0.5), calc.sqrt(0.5))
  let f = (-calc.sqrt(0.5), calc.sqrt(0.5))
  // traction on the cut, compression positive: it acts against n
  let T = (50 / calc.sqrt(2), 70 / calc.sqrt(2))     // MPa
  let k = 0.22                                         // mm per MPa
  let sn = 60
  let tau-mpa = 10
  let tip = (m.at(0) - k * T.at(0), m.at(1) - k * T.at(1))
  let start = (m.at(0) + k * T.at(0), m.at(1) + k * T.at(1))
  // components (drawn arriving at the plane, like the traction)
  let s0 = (m.at(0) + k * sn * n.at(0), m.at(1) + k * sn * n.at(1))
  line(s0, m, stroke: (paint: force, thickness: 0.7pt, dash: "dashed"), mark: (end: "stealth", fill: force, scale: 0.45))
  let t0 = (m.at(0) + k * tau-mpa * f.at(0) * 2.2, m.at(1) + k * tau-mpa * f.at(1) * 2.2)   // shear force along -f (compression positive)
  line(t0, m, stroke: (paint: force, thickness: 0.7pt, dash: "dashed"), mark: (end: "stealth", fill: force, scale: 0.45))
  line(start, m, ..a-force)
  // unit normal
  line(m, (m.at(0) + 7 * n.at(0), m.at(1) + 7 * n.at(1)), stroke: s-interface, mark: (end: "stealth", fill: ink, scale: 0.45))
  content((m.at(0) + 7 * n.at(0) + 1, m.at(1) + 7 * n.at(1) - 1.5), anchor: "west", $bold(n)$)
  content((start.at(0) + 0.8, start.at(1)), anchor: "west", $bold(T)$)
  small((s0.at(0) + 1.2, s0.at(1) - 1.2), $sigma_n$, anchor: "north-west")
  small((t0.at(0) - 1, t0.at(1) - 0.5), $tau$, anchor: "east")
})
