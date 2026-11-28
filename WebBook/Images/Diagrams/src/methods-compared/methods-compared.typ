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
        circle((x + i * h, j * h), radius: r, fill: paper, stroke: (paint: mesh-grey, thickness: 0.4pt))
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
  // Particles carry the material; each one contributes to the centre of the
  // cell it sits in. Most cells hold one particle; the shaded cell holds
  // several, straddling the interface between two materials (blue circles,
  // green squares), and so receives a mixture.
  let xd = x0(3)
  let (mi, mj) = (2, 2)                          // the cell with several particles
  rect((xd + mi * h, mj * h), (xd + (mi + 1) * h, (mj + 1) * h), fill: emphasis-tint, stroke: none)
  grid-lines(xd)
  // material interface
  let (ic, isl) = (12.6, 0.35)
  let yint(x) = ic + isl * x
  line((xd, yint(0)), (xd + W, yint(W)), stroke: (paint: ink, thickness: w-construct, dash: "dashed"))

  let pts = ()
  for i in range(n) {
    for j in range(n) {
      let cx = (i + 0.5) * h
      let cy = (j + 0.5) * h
      if (i, j) == (mi, mj) {
        for (dxp, dyp) in ((-2.8, -3.0), (1.4, -2.9), (-2.4, 2.4), (2.6, 2.0), (0.4, 3.2)) {
          pts.push(((i, j), (cx + dxp, cy + dyp)))
        }
      } else {
        let a = (i * 2.3 + j * 1.7) * 1.9
        pts.push(((i, j), (cx + 2.4 * calc.cos(a), cy + 2.4 * calc.sin(a))))
      }
    }
  }
  // keep every particle clearly on one side of the interface: a particle
  // within 1.6 mm of it is mirrored through its cell centre (same cell)
  let nn = calc.sqrt(1 + isl * isl)
  let dist(q) = (q.at(1) - yint(q.at(0))) / nn
  pts = pts.map(((cell, p)) => {
    if calc.abs(dist(p)) >= 1.6 or cell == (mi, mj) { (cell, p) } else {
      let c = ((cell.at(0) + 0.5) * h, (cell.at(1) + 0.5) * h)
      (cell, (2 * c.at(0) - p.at(0), 2 * c.at(1) - p.at(1)))
    }
  })
  // contributions to cell centres
  for (cell, p) in pts {
    let c = ((cell.at(0) + 0.5) * h, (cell.at(1) + 0.5) * h)
    line((xd + p.at(0), p.at(1)), (xd + c.at(0), c.at(1)), stroke: s-construct)
  }
  for i in range(n) {
    for j in range(n) {
      circle((xd + (i + 0.5) * h, (j + 0.5) * h), radius: 0.8, fill: paper, stroke: (paint: ink, thickness: 0.5pt))
    }
  }
  for (cell, p) in pts {
    let q = (xd + p.at(0), p.at(1))
    if p.at(1) < yint(p.at(0)) {
      circle(q, radius: 0.85, fill: material-a, stroke: none)
    } else {
      rect((q.at(0) - 0.8, q.at(1) - 0.8), (q.at(0) + 0.8, q.at(1) + 0.8), fill: material-b, stroke: none)
    }
  }
  panel-label(xd, [(d) particle-in-cell])
})
