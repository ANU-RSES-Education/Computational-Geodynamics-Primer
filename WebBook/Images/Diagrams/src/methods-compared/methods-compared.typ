// What each discretisation method represents, on the same patch of domain.
// (a) finite differences: point values and a 5-point stencil
// (b) finite elements: a nodal basis function and its support
// (c) finite volumes: a control volume and the fluxes across its faces
// (d) particle-in-cell: material points carried through a background grid
//
// Build:  pixi run figures   (or see ../README.md)

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let h = 8          // node spacing, mm at final size
  let n = 4          // intervals per side
  let W = n * h      // panel width
  let gap = 13
  let x0(k) = k * (W + gap)

  let grid-lines(x) = {
    for i in range(n + 1) {
      line((x + i * h, 0), (x + i * h, W), stroke: s-mesh)
      line((x, i * h), (x + W, i * h), stroke: s-mesh)
    }
  }
  let nodes(x, r: 0.45) = {
    for i in range(n + 1) {
      for j in range(n + 1) {
        circle((x + i * h, j * h), radius: r, fill: white, stroke: (paint: mesh-grey, thickness: 0.4pt))
      }
    }
  }
  let key-node(p) = circle(p, radius: 1.0, fill: ink, stroke: none)
  let panel-label(x, body) = content((x + W / 2, -4.5), anchor: "north", body)

  // ---- (a) finite differences -------------------------------------------
  let xa = x0(0)
  grid-lines(xa)
  nodes(xa)
  line((xa + 1 * h, 2 * h), (xa + 3 * h, 2 * h), stroke: s-interface)
  line((xa + 2 * h, 1 * h), (xa + 2 * h, 3 * h), stroke: s-interface)
  for p in ((2, 2), (1, 2), (3, 2), (2, 1), (2, 3)) {
    key-node((xa + p.at(0) * h, p.at(1) * h))
  }
  panel-label(xa, [(a) finite differences])

  // ---- (b) finite elements ----------------------------------------------
  let xb = x0(1)
  // support of the basis function at node (2,2): the six triangles sharing it
  let support = ((1, 1), (2, 1), (3, 2), (3, 3), (2, 3), (1, 2)).map(p => (xb + p.at(0) * h, p.at(1) * h))
  line(..support, close: true, fill: emphasis-tint, stroke: none)
  grid-lines(xb)
  for i in range(n) {
    for j in range(n) {
      line((xb + i * h, j * h), (xb + (i + 1) * h, (j + 1) * h), stroke: s-mesh)
    }
  }
  line(..support, close: true, stroke: s-interface)
  nodes(xb)
  key-node((xb + 2 * h, 2 * h))
  panel-label(xb, [(b) finite elements])

  // ---- (c) finite volumes -----------------------------------------------
  let xc = x0(2)
  grid-lines(xc)
  nodes(xc)
  let c = (xc + 2 * h, 2 * h)
  rect((c.at(0) - h / 2, c.at(1) - h / 2), (c.at(0) + h / 2, c.at(1) + h / 2),
       fill: emphasis-tint, stroke: s-hidden)
  // one flux arrow through the midpoint of each face, normal to it
  let L = 2.8   // arrow half-length
  for d in ((1, 0), (-1, 0), (0, 1), (0, -1)) {
    let f = (c.at(0) + d.at(0) * h / 2, c.at(1) + d.at(1) * h / 2)
    line((f.at(0) - d.at(0) * L, f.at(1) - d.at(1) * L),
         (f.at(0) + d.at(0) * L, f.at(1) + d.at(1) * L), ..a-energy)
  }
  key-node(c)
  panel-label(xc, [(c) finite volumes])

  // ---- (d) particle-in-cell ---------------------------------------------
  let xd = x0(3)
  grid-lines(xd)
  nodes(xd, r: 0.35)
  let pts = ((4.7, 6.2), (5.5, 2.5), (2.9, 14.1), (1.2, 13.8), (5.7, 19.8), (2.9, 18.8), (2.6, 27.7), (4.0, 28.3), (14.8, 5.6), (12.7, 6.7), (10.4, 10.1), (12.6, 9.4), (9.4, 20.1), (11.8, 22.3), (12.7, 28.1), (12.0, 26.6), (17.3, 2.3), (21.1, 2.3), (19.3, 9.2), (21.8, 10.1), (18.7, 22.1), (20.1, 21.9), (20.8, 29.4), (17.7, 28.2), (28.0, 6.1), (27.2, 4.5), (25.5, 11.4), (27.0, 10.0), (29.8, 19.3), (30.7, 20.5), (28.6, 28.8), (29.0, 26.0))
  // a few particles carry a velocity arrow: material moves, the grid does not
  for (k, v) in ((10, (4.0, 2.0)), (13, (4.0, -1.5)), (19, (3.0, 3.0))) {
    let p = pts.at(k)
    line((xd + p.at(0), p.at(1)), (xd + p.at(0) + v.at(0), p.at(1) + v.at(1)), ..a-velocity)
  }
  for p in pts {
    circle((xd + p.at(0), p.at(1)), radius: 0.75, fill: ink, stroke: none)
  }
  panel-label(xd, [(d) particle-in-cell])
})
