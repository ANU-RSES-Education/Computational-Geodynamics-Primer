// One-dimensional linear finite elements (fem-practice, fig-discretisation-1d).
// Top:    a smooth field u (dashed) and its piecewise-linear interpolant u^h.
// Middle: u^h is the sum of scaled basis functions u(x_A) N_A.
// Bottom: two unit basis functions N_A, N_B: one at their own node, zero at
//         every other node, so each overlaps only its neighbours.
// Single column (90 mm).
//
// Build:  pixi run figures fem-1d-basis

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let n = 5                  // elements
  let h = 15                 // node spacing, mm
  let W = n * h
  let xs = range(n + 1).map(i => i * h)
  let u(x) = 9 + 5 * calc.sin(x / 11) + 3 * calc.cos(x / 6.5)
  let node(p, r: 0.9) = circle(p, radius: r, fill: ink, stroke: none)
  let axis(y) = line((-3, y), (W + 3, y), stroke: s-construct)
  let ticks(y) = for x in xs { line((x, y - 0.8), (x, y + 0.8), stroke: s-construct) }
  let row-label(y, body) = content((-5, y), anchor: "east", body)

  // ---- top: u and u^h ------------------------------------------------------
  let y0 = 44
  axis(y0)
  ticks(y0)
  let smooth = range(0, 151).map(k => { let x = k * W / 150; (x, y0 + u(x)) })
  line(..smooth, stroke: (paint: ink, thickness: w-construct, dash: "dashed"))
  line(..xs.map(x => (x, y0 + u(x))), stroke: s-interface)
  for x in xs { node((x, y0 + u(x)), r: 0.75) }
  content((W + 2, y0 + u(W) + 2.5), anchor: "west", $u$)
  content(((xs.at(4) + xs.at(5)) / 2 - 1.5, y0 + (u(xs.at(4)) + u(xs.at(5))) / 2 + 1), anchor: "south-east", $u^h$)
  row-label(y0 + 8, [(a)])

  // ---- middle: scaled hats summing to u^h ----------------------------------
  let y1 = 22
  axis(y1)
  ticks(y1)
  for (i, x) in xs.enumerate() {
    let l = if i == 0 { (x, y1 + u(x)) } else { (x - h, y1) }
    let r = if i == n { (x, y1 + u(x)) } else { (x + h, y1) }
    line(l, (x, y1 + u(x)), r, stroke: s-construct)
    line((x, y1), (x, y1 + u(x)), stroke: (paint: mesh-grey, thickness: w-mesh, dash: "dotted"))
    node((x, y1 + u(x)), r: 0.7)
  }
  content((xs.at(2), y1 + u(xs.at(2)) + 2.5), anchor: "south", $u(x_A) N_A$)
  row-label(y1 + 8, [(b)])

  // ---- bottom: unit basis functions N_A and N_B ----------------------------
  let y2 = 0
  let H = 12                 // height of a unit basis function, mm
  axis(y2)
  for x in xs { node((x, y2), r: 0.7) }
  let a = 2
  let b = 3
  line((xs.at(a - 1), y2), (xs.at(a), y2 + H), (xs.at(a + 1), y2), stroke: s-interface)
  line((xs.at(b - 1), y2), (xs.at(b), y2 + H), (xs.at(b + 1), y2), stroke: s-hidden)
  content((xs.at(a), y2 + H + 1.5), anchor: "south", $N_A$)
  content((xs.at(b), y2 + H + 1.5), anchor: "south", $N_B$)
  content((xs.at(a), y2 - 2), anchor: "north", $A$)
  content((xs.at(b), y2 - 2), anchor: "north", $B$)
  // unit height
  line((xs.at(a - 1) - 4, y2), (xs.at(a - 1) - 4, y2 + H), ..a-dimension)
  content((xs.at(a - 1) - 5, y2 + H / 2), anchor: "east", $1$)
  line((xs.at(a - 1) - 5.5, y2 + H), (xs.at(a), y2 + H), stroke: (paint: mesh-grey, thickness: w-mesh, dash: "dotted"))
  row-label(y2 + 8, [(c)])
})
