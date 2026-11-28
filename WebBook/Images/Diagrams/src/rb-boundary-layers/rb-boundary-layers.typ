// Boundary-layer theory in its simplest form (rayleigh-benard-convection,
// fig-boundary-layer-theory-1). One convection cell of depth d: an isothermal
// interior at Delta T / 2, rotating rigidly with vorticity omega_i, and thin
// boundary layers of thickness delta around it (hot along the base and up the
// rising side, cold along the top and down the sinking side) in which heat
// diffuses in or out and the flow speed is v.
// Single column (90 mm).
//
// Build:  pixi run figures rb-boundary-layers

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let d = 40
  let dl = 5.5                         // boundary-layer thickness as drawn
  let small(pos, body, anchor: "center") = content(pos, anchor: anchor, text(7.5pt, body))

  // cell, boundary-layer band, interior
  rect((0, 0), (d, d), fill: emphasis-tint, stroke: none)
  rect((dl, dl), (d - dl, d - dl), fill: fluid-tint, stroke: s-hidden)
  line((-3, d), (d + 3, d), stroke: s-boundary)
  line((-3, 0), (d + 3, 0), stroke: s-boundary)
  line((0, 0), (0, d), stroke: s-interface)
  line((d, 0), (d, d), stroke: s-interface)
  small((d / 2, d / 2 + 3), $T = Delta T \/ 2$)
  small((d / 2, d / 2 - 3), $omega = omega_i$)
  small((d / 2, d + 1.5), $T = 0$, anchor: "south")
  small((d / 2, -1.5), $T = Delta T$, anchor: "north")

  // flow in the boundary layers: clockwise, rising on the left
  let m = dl / 2
  line((8, d - m), (d - 8, d - m), ..a-velocity)
  line((d - m, d - 8), (d - m, 8), ..a-velocity)
  line((d - 8, m), (8, m), ..a-velocity)
  line((m, 8), (m, d - 8), ..a-velocity)
  small((dl + 1.8, d / 2), $v$, anchor: "west")

  // dimensions
  line((-5, 0), (-5, d), ..a-dimension)
  small((-6, d / 2), $d$, anchor: "east")
  line((d + 5, d), (d + 5, d - dl), ..a-dimension)
  small((d + 6, d - dl / 2), $delta$, anchor: "west")
})
