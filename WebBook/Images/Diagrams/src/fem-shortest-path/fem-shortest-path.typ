// Shortest path between two points as a variational problem
// (fem-introduction, fig-variational). The straight line Gamma joins x1 and x2;
// other admissible curves (dashed) share the end points. A short segment dS
// of Gamma is marked: the length is the integral of dS along the curve.
// Single column (90 mm).
//
// Build:  pixi run figures fem-shortest-path

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let p1 = (0, 0)
  let p2 = (62, 34)
  let alt = (paint: ink, thickness: w-construct, dash: "dashed")

  // admissible curves through the same end points
  bezier(p1, p2, (14, 30), (40, 46), stroke: alt)
  bezier(p1, p2, (30, -16), (78, 6), stroke: alt)
  bezier(p1, p2, (6, 14), (70, 12), stroke: alt)

  // the straight line and a marked element dS
  line(p1, p2, stroke: s-boundary)
  let t1 = 0.30
  let t2 = 0.40
  let q1 = (p2.at(0) * t1, p2.at(1) * t1)
  let q2 = (p2.at(0) * t2, p2.at(1) * t2)
  let nrm = (-0.48, 0.88)               // unit normal to the line
  for q in (q1, q2) {
    line((q.at(0) - 1.6 * nrm.at(0), q.at(1) - 1.6 * nrm.at(1)),
         (q.at(0) + 1.6 * nrm.at(0), q.at(1) + 1.6 * nrm.at(1)), stroke: s-interface)
  }
  content(((q1.at(0) + q2.at(0)) / 2 + 2.5, (q1.at(1) + q2.at(1)) / 2 - 2.5), anchor: "north-west", $d S$)
  content((p2.at(0) * 0.62 - 2.5, p2.at(1) * 0.62 + 2.5), anchor: "south-east", $Gamma$)

  for (p, lab, anc) in ((p1, $bold(x)_1$, "north-east"), (p2, $bold(x)_2$, "south-west")) {
    circle(p, radius: 1.2, fill: ink, stroke: none)
    content((p.at(0) + if anc == "north-east" { -1.5 } else { 1.5 }, p.at(1) + if anc == "north-east" { -1.5 } else { 1.5 }), anchor: anc, lab)
  }
})
