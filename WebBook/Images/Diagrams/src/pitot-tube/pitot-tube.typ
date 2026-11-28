// Pitot tube (inviscid-flows, fig-pitot).
// A tube facing upstream brings the flow to rest at its mouth, so it senses the
// stagnation pressure p_stag; a tap in the wall, normal to the flow, senses
// the static pressure p_0. Each feeds a manometer column; the difference in
// level measures p_stag - p_0 = rho U_0^2 / 2.
// Single column (90 mm).
//
// Build:  pixi run figures pitot-tube

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let L = 70
  let D = 16                        // channel depth
  let t = 1.6                       // tube half-width
  // channel
  rect((0, 0), (L, D), fill: fluid-tint, stroke: none)
  line((0, 0), (L, 0), stroke: s-boundary)
  line((0, D), (38, D), stroke: s-boundary)
  line((38 + 2 * t, D), (54, D), stroke: s-boundary)
  line((54 + 2 * t, D), (L, D), stroke: s-boundary)
  for yy in (3.5, 8, 12.5) { line((2, yy), (11, yy), ..a-velocity) }
  content((6.5, 1.2), anchor: "south", $U_0$)

  // Pitot tube: mouth facing upstream at mid-depth, rising to column 1
  let xm = 22
  let ym = D / 2
  let c1 = 38 + t                   // column centre
  line((xm, ym + t), (c1 - t, ym + t), (c1 - t, D + 22), stroke: s-interface)
  line((xm, ym - t), (c1 + t, ym - t), (c1 + t, D + 22), stroke: s-interface)
  rect((c1 - t, ym - t), (c1 + t, D + 16), fill: fluid-tint, stroke: none)
  line((c1 - t, D + 16), (c1 + t, D + 16), stroke: s-interface)
  circle((xm, ym), radius: 0.8, fill: ink, stroke: none)
  content((xm - 1.5, ym + 1.5), anchor: "south-east", $p_"stag"$)

  // static tap in the wall, column 2
  let c2 = 54 + t
  line((c2 - t, D), (c2 - t, D + 22), stroke: s-interface)
  line((c2 + t, D), (c2 + t, D + 22), stroke: s-interface)
  rect((c2 - t, D), (c2 + t, D + 8), fill: fluid-tint, stroke: none)
  line((c2 - t, D + 8), (c2 + t, D + 8), stroke: s-interface)
  content((c2 + t + 1.5, D + 3), anchor: "west", $p_0$)

  // level difference
  line((c1 + t + 1.5, D + 16), (c2 - t - 1.5, D + 16), stroke: (paint: mesh-grey, thickness: w-mesh, dash: "dotted"))
  line((c2 - t - 4, D + 8), (c2 - t - 4, D + 16), ..a-dimension)
  content((c2 + t + 1.5, D + 13), anchor: "west", $Delta h$)
})
