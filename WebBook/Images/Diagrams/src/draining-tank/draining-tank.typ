// Torricelli: a tank draining through a small orifice (inviscid-flows,
// fig-torricelli). The free surface B is at height h above the orifice A;
// both are at atmospheric pressure p_0. Along the streamline from B to A
// (dashed) Bernoulli gives the exit speed u_A = sqrt(2 g h).
// Single column (90 mm).
//
// Build:  pixi run figures draining-tank

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let W = 34
  let H = 34
  let h = 26                       // free surface above the orifice
  let ya = 4                       // orifice height
  // water
  rect((0, 0), (W, ya + h), fill: fluid-tint, stroke: none)
  line((0, ya + h), (W, ya + h), stroke: s-interface)
  // tank walls with an opening at A on the right
  line((0, H), (0, 0), (W, 0), (W, ya - 1.2), stroke: s-boundary)
  line((W, ya + 1.2), (W, H), stroke: s-boundary)
  // the jet: a parabola leaving horizontally from A
  let ua = 1.0
  let jet(t) = (W + 14 * t, ya - 9 * t * t)
  let edge(dy) = range(0, 21).map(k => { let t = k / 20; let p = jet(t); (p.at(0), p.at(1) + dy) })
  line(..edge(1.2), ..edge(-1.2).rev(), close: true, fill: fluid-tint, stroke: none)
  line(..edge(1.2), stroke: s-construct)
  line(..edge(-1.2), stroke: s-construct)
  line((W + 1, ya), (W + 9, ya + 0.2), ..a-velocity)
  content((W + 9.5, ya + 2), anchor: "south-west", $u_A$)
  // streamline from B to A
  bezier((10, ya + h), (W - 0.5, ya), (8, ya + 6), (22, ya + 0.5), stroke: s-hidden)
  circle((10, ya + h), radius: 0.9, fill: ink, stroke: none)
  circle((W, ya), radius: 0.9, fill: ink, stroke: none)
  content((10, ya + h + 1.5), anchor: "south", $B$)
  content((W - 1.5, ya + 1.5), anchor: "south-east", $A$)
  content((W - 4, ya + h + 1.5), anchor: "south", $p_0$)
  // height
  line((-4, ya), (-4, ya + h), ..a-dimension)
  content((-5, ya + h / 2), anchor: "east", $h$)
  line((-5.5, ya), (W - 1, ya), stroke: (paint: mesh-grey, thickness: w-mesh, dash: "dotted"))
})
