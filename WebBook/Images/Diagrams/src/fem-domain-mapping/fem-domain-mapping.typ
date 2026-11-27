// Domain decomposition and the element mapping (fem-practice, fig-domain-decomp).
// A domain Omega with curved boundary Gamma is split into six quadrilateral
// elements Omega^1..Omega^6. Element edges are straight and their corners lie on
// Gamma, so the slivers between the mesh and Gamma are the boundary error.
// Each element is the image of the reference square in (xi, eta) under a
// change of variables x(xi, eta).
// Single column (90 mm).
//
// Build:  pixi run figures fem-domain-mapping

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  // mesh vertices: three rows of four; the outer ones lie on Gamma
  let T = ((8, 40), (24, 44), (42, 43), (56, 37))
  let M = ((2, 22), (22, 24), (40, 23), (60, 20))
  let B = ((8, 4), (24, 0), (42, 1), (56, 6))
  let c = (31, 22)

  // Gamma: a smooth curve through the boundary vertices, bulging outward between them
  let ring = (T.at(0), T.at(1), T.at(2), T.at(3), M.at(3), B.at(3), B.at(2), B.at(1), B.at(0), M.at(0))
  let pts = ()
  for (k, p) in ring.enumerate() {
    let q = ring.at(calc.rem(k + 1, ring.len()))
    let m = ((p.at(0) + q.at(0)) / 2, (p.at(1) + q.at(1)) / 2)
    let d = (m.at(0) - c.at(0), m.at(1) - c.at(1))
    let r = calc.sqrt(d.at(0) * d.at(0) + d.at(1) * d.at(1))
    pts.push(p)
    pts.push((m.at(0) + 2.6 * d.at(0) / r, m.at(1) + 2.6 * d.at(1) / r))
  }
  catmull(..pts, close: true, fill: solid-tint, stroke: s-boundary)

  // elements
  let quads = (
    (T.at(0), T.at(1), M.at(1), M.at(0)), (T.at(1), T.at(2), M.at(2), M.at(1)), (T.at(2), T.at(3), M.at(3), M.at(2)),
    (M.at(0), M.at(1), B.at(1), B.at(0)), (M.at(1), M.at(2), B.at(2), B.at(1)), (M.at(2), M.at(3), B.at(3), B.at(2)),
  )
  // the mapped element is shaded
  line(..quads.at(1), close: true, fill: emphasis-tint, stroke: none)
  for q in quads { line(..q, close: true, stroke: s-interface) }
  for (k, q) in quads.enumerate() {
    let cx = q.map(p => p.at(0)).sum() / 4
    let cy = q.map(p => p.at(1)).sum() / 4
    content((cx, cy), $Omega^#(k + 1)$)
  }
  for p in T + M + B { circle(p, radius: 0.6, fill: ink, stroke: none) }
  content((63, 32), anchor: "west", $Gamma$)
  content((0, 40), anchor: "east", $Omega$)

  // reference element and the mapping
  let r0 = (74, 46)
  let s = 13
  rect(r0, (r0.at(0) + s, r0.at(1) + s), fill: emphasis-tint, stroke: s-interface)
  let o = (r0.at(0) + s / 2, r0.at(1) + s / 2)
  line(o, (o.at(0) + s / 2 + 4, o.at(1)), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  line(o, (o.at(0), o.at(1) + s / 2 + 4), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  content((o.at(0) + s / 2 + 4.5, o.at(1)), anchor: "west", $xi$)
  content((o.at(0), o.at(1) + s / 2 + 4.5), anchor: "south", $eta$)
  bezier((r0.at(0) - 1, r0.at(1) + 3), (34, 37), (52, 58), (38, 56),
         stroke: (paint: ink, thickness: w-construct), mark: (end: "stealth", fill: ink, scale: 0.5))
  content((56, 56), anchor: "south", $bold(x)(xi, eta)$)
})
