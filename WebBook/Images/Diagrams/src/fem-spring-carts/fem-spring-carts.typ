// Spring-and-cart system used to introduce assembly (fem-introduction,
// fig-mine-carts).
// (a) Three carts on a level track joined by five springs: k1 from the wall
//     to cart 1, k2 and k3 in parallel between carts 1 and 2, k4 from cart 1
//     to cart 3 over the top, k5 between carts 2 and 3. Each cart carries a
//     load R_i (force arrow) and moves by U_i (displacement arrow).
// (b) The element diagram for spring k2: end displacements U1, U2 and the
//     forces F1^(2), F2^(2) at its two ends, both positive in +x.
// Double column (183 mm).
//
// Build:  pixi run figures fem-spring-carts

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  // horizontal spring between x1 and x2 at height y
  let spring(x1, x2, y, coils: 7, amp: 1.4, lead: 2.5) = {
    let a = x1 + lead
    let b = x2 - lead
    let n = 2 * coils
    let pts = ((x1, y), (a, y))
    for k in range(1, n) {
      pts.push((a + k * (b - a) / n, y + if calc.odd(k) { amp } else { -amp }))
    }
    pts += ((b, y), (x2, y))
    line(..pts, stroke: s-interface)
  }
  let hatch-below(x1, x2, y, step: 2.5, d: 2) = {
    for k in range(int((x2 - x1) / step) + 1) {
      let x = x1 + k * step
      line((x, y), (x - d, y - d), stroke: s-construct)
    }
  }
  let cart(x, w, label) = {
    rect((x, 4), (x + w, 18), fill: solid-tint, stroke: s-boundary)
    for wx in (x + 5, x + w - 5) {
      circle((wx, 2), radius: 2, fill: paper, stroke: s-interface)
    }
    content((x + w / 2, 8), text(10pt, weight: "bold", label))
  }

  // ---- (a) the system --------------------------------------------------------
  let w = 22
  let c = (22, 64, 106)            // left edges of the three carts
  // ground and wall
  line((0, 0), (c.at(2) + w + 8, 0), stroke: s-boundary)
  hatch-below(1, c.at(2) + w + 8, 0)
  line((0, 0), (0, 24), stroke: s-boundary)
  for k in range(9) { line((0, 2 + k * 2.6), (-2, 2 + k * 2.6 - 2), stroke: s-construct) }

  for (i, x) in c.enumerate() { cart(x, w, str(i + 1)) }

  // springs
  spring(0, c.at(0), 11)
  spring(c.at(0) + w, c.at(1), 14)
  spring(c.at(0) + w, c.at(1), 8)
  spring(c.at(1) + w, c.at(2), 11)
  // k4 over the top on rigid links from the tops of carts 1 and 3
  let top = 30
  let l1 = c.at(0) + w / 2
  let l3 = c.at(2) + w / 2
  line((l1, 18), (l1, top), (l1 + 12, top), stroke: s-interface)
  spring(l1 + 12, l3 - 12, top)
  line((l3 - 12, top), (l3, top), (l3, 18), stroke: s-interface)

  content((c.at(0) / 2, 13.5), anchor: "south", $k_1$)
  content(((c.at(0) + w + c.at(1)) / 2, 16.5), anchor: "south", $k_2$)
  content(((c.at(0) + w + c.at(1)) / 2, 5.5), anchor: "north", $k_3$)
  content(((l1 + l3) / 2, top + 2.5), anchor: "south", $k_4$)
  content(((c.at(1) + w + c.at(2)) / 2, 13.5), anchor: "south", $k_5$)

  // loads (force) and displacements, drawn inside the upper part of each cart
  for (i, x) in c.enumerate() {
    let xa = x + 3
    line((xa, 15.5), (xa + 7, 15.5), ..a-force)
    content((xa + 7.5, 15.5), anchor: "west", $R_#(i + 1)$)
    line((x + 3, 11.5), (x + 10, 11.5), ..a-velocity)
    content((x + 10.5, 11.5), anchor: "west", $U_#(i + 1)$)
  }
  content((70, -6), anchor: "north", [(a)])

  // ---- (b) element diagram for k2 ------------------------------------------
  let yb = -24
  let n1 = 46
  let n2 = 86
  spring(n1, n2, yb, coils: 8)
  for x in (n1, n2) { circle((x, yb), radius: 0.9, fill: ink, stroke: none) }
  line((n1 - 15, yb), (n1 - 1.2, yb), ..a-force)
  content((n1 - 15, yb + 1.5), anchor: "south-west", $F_1^((2))$)
  line((n2 + 1.2, yb), (n2 + 15, yb), ..a-force)
  content((n2 + 15, yb + 1.5), anchor: "south-east", $F_2^((2))$)
  for (x, lab) in ((n1, $U_1$), (n2, $U_2$)) {
    line((x, yb + 1.2), (x, yb + 7), stroke: (paint: mesh-grey, thickness: w-mesh, dash: "dotted"))
    line((x, yb + 7), (x + 8, yb + 7), ..a-velocity)
    content((x + 8.5, yb + 7), anchor: "west", lab)
  }
  content(((n1 + n2) / 2, yb - 3), anchor: "north", $k_2$)
  content((70, yb - 9), anchor: "north", [(b)])
})
