// An arbitrary volume of material (conservation-laws, fig-volume-element).
// Volume Omega with surface Gamma; a surface element d Gamma is a vector
// normal to the surface, pointing outward, with magnitude equal to its area.
// Single column (90 mm).
//
// Build:  pixi run figures volume-element

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let ring = ((0, 12), (7, 25), (20, 30), (34, 27), (47, 33), (59, 27), (57, 12), (44, 4), (26, 0), (10, 2))
  catmull(..ring, close: true, fill: fluid-tint, stroke: s-boundary)

  // surface element at (20, 30): tangent from the neighbouring points
  let p = (20, 30)
  let t = (34 - 7, 27 - 25)
  let tl = calc.sqrt(t.at(0) * t.at(0) + t.at(1) * t.at(1))
  let tu = (t.at(0) / tl, t.at(1) / tl)
  let nu = (-tu.at(1), tu.at(0))                // outward normal (the curve runs clockwise here)
  let a = (p.at(0) - 3.5 * tu.at(0), p.at(1) - 3.5 * tu.at(1))
  let b = (p.at(0) + 3.5 * tu.at(0), p.at(1) + 3.5 * tu.at(1))
  line(a, b, stroke: (paint: ink, thickness: 2pt))
  line(p, (p.at(0) + 11 * nu.at(0), p.at(1) + 11 * nu.at(1)), stroke: (paint: ink, thickness: w-interface),
       mark: (end: "stealth", fill: ink, scale: 0.6))
  content((p.at(0) + 11 * nu.at(0) + 1.5, p.at(1) + 11 * nu.at(1)), anchor: "west", $bold(d)bold(Gamma)$)

  content((28, 14), $Omega$)
  content((60, 31), anchor: "west", $Gamma$)
})
