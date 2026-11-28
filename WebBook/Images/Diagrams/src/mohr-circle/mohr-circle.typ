// The Mohr circle (stress-and-faulting, fig-mohr-circle).
// Left: an element under sigma_1 (vertical) and sigma_3 (horizontal), cut by a
// plane whose normal makes angle theta with sigma_1.
// Right: the Mohr circle, centre (sigma_1 + sigma_3)/2, radius
// (sigma_1 - sigma_3)/2; the plane plots at 2 theta round the circle from the
// sigma_1 point. theta = 30 degrees here. Compression positive.
// Double column (183 mm).
//
// Build:  pixi run figures mohr-circle

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let th = 30                                     // degrees, normal to sigma_1
  let small(pos, body, anchor: "center") = content(pos, anchor: anchor, text(7.5pt, body))

  // ---- left: the element -----------------------------------------------------------
  let a = 20
  let c = (a / 2, a / 2)
  rect((0, 0), (a, a), fill: solid-tint, stroke: s-boundary)
  for x in (a / 2 - 4, a / 2 + 4) {
    line((x, a + 10), (x, a + 1), ..a-force)
    line((x, -10), (x, -1), ..a-force)
  }
  line((-8, a / 2), (-1, a / 2), ..a-force)
  line((a + 8, a / 2), (a + 1, a / 2), ..a-force)
  small((a / 2 + 5, a + 9.5), $sigma_1$, anchor: "west")
  small((a + 7, a / 2 + 1.5), $sigma_3$, anchor: "south")
  // the plane: its normal is at theta from vertical (sigma_1)
  let nrm = (calc.sin(th * 1deg), calc.cos(th * 1deg))
  let tng = (nrm.at(1), -nrm.at(0))
  let L = 13
  line((c.at(0) - L * tng.at(0), c.at(1) - L * tng.at(1)), (c.at(0) + L * tng.at(0), c.at(1) + L * tng.at(1)),
       stroke: (paint: ink, thickness: w-boundary))
  line(c, (c.at(0) + 9 * nrm.at(0), c.at(1) + 9 * nrm.at(1)), stroke: s-interface, mark: (end: "stealth", fill: ink, scale: 0.45))
  line(c, (c.at(0), c.at(1) + 9), stroke: (paint: ink, thickness: w-construct, dash: "dashed"))
  arc(c, start: 90deg, stop: 90deg - th * 1deg, radius: 6, anchor: "origin", stroke: s-construct)
  small((c.at(0) + 2.2, c.at(1) + 7.3), $theta$)
  content((c.at(0) + 9 * nrm.at(0) + 0.6, c.at(1) + 9 * nrm.at(1) + 0.4), anchor: "south-west", $bold(n)$)

  // ---- right: the circle -------------------------------------------------------------
  let o = (52, -6)                                // origin of the Mohr axes
  let s1 = 100
  let s3 = 40                                     // stresses, arbitrary units
  let k = 0.55                                    // mm per unit
  let X(s) = o.at(0) + k * s
  let Y(t) = o.at(1) + k * t
  let cen = (s1 + s3) / 2
  let R = (s1 - s3) / 2
  line((o.at(0), o.at(1)), (X(s1 + 18), o.at(1)), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  line((o.at(0), Y(-R - 6)), (o.at(0), Y(R + 10)), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  content((X(s1 + 18) + 1, o.at(1)), anchor: "west", $sigma_n$)
  content((o.at(0), Y(R + 10) + 1), anchor: "south", $tau$)
  circle((X(cen), Y(0)), radius: k * R, stroke: s-interface)
  // the plane's point
  let P = (X(cen + R * calc.cos(2 * th * 1deg)), Y(R * calc.sin(2 * th * 1deg)))
  line((X(cen), Y(0)), P, stroke: s-construct)
  arc((X(cen), Y(0)), start: 0deg, stop: 2 * th * 1deg, radius: 7, anchor: "origin", stroke: s-construct)
  small((X(cen) + 8, Y(0) + 2.6), $2 theta$, anchor: "west")
  circle(P, radius: 0.9, fill: ink, stroke: none)
  small((P.at(0) + 1.2, P.at(1) + 1), $(sigma_n, tau)$, anchor: "south-west")
  for (s, lab) in ((s3, $sigma_3$), (s1, $sigma_1$)) {
    circle((X(s), Y(0)), radius: 0.8, fill: ink, stroke: none)
    small((X(s) + 1, Y(0) - 1.2), lab, anchor: "north-west")
  }
  circle((X(cen), Y(0)), radius: 0.5, fill: ink, stroke: none)
  // projections of the point
  line(P, (P.at(0), Y(0)), stroke: (paint: mesh-grey, thickness: w-mesh, dash: "dotted"))
  line(P, (o.at(0), P.at(1)), stroke: (paint: mesh-grey, thickness: w-mesh, dash: "dotted"))
  // centre and radius
  line((X(s3), Y(-R - 3)), (X(cen), Y(-R - 3)), ..a-dimension)
  line((X(cen), Y(-R - 3)), (X(s1), Y(-R - 3)), ..a-dimension)
  small(((X(s3) + X(cen)) / 2, Y(-R - 3) - 1), $(sigma_1 - sigma_3) \/ 2$, anchor: "north")
  small((X(cen), Y(0) - 1.2), $(sigma_1 + sigma_3) \/ 2$, anchor: "north")
})
