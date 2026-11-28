// Multigrid (solvers, fig-multigrid-diagram).
// (a) The error through one two-level V cycle, computed (multigrid.py): the
//     smoother removes the oscillatory part, the coarse grid removes the
//     smooth part. All rows on one scale.
// (b) The bilinear basis function of one node on a coarse grid (H) and on a
//     fine grid (h): the coarse function reaches twice as far.
// (c)-(e) Level schedules on four grids: V cycle, W cycle, full multigrid.
//     In (e) the heavier steps are the interpolations to a new, finer level.
// Double column (183 mm).
//
// Build:  pixi run figures multigrid   (runs multigrid.py first)

#import "../primerfig.typ": *
#show: fig-setup
#let data = json("multigrid.json")

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  // ---- (a) error through a V cycle ---------------------------------------
  let Wa = 46
  let A = 5.2                       // mm per unit error
  for (r, row) in data.rows.enumerate() {
    let y = 66 - r * 12.5
    let xs = if row.grid == "fine" { data.fine_x } else { data.coarse_x }
    line((0, y), (Wa, y), stroke: s-mesh)
    let pts = xs.zip(row.e).map(((x, e)) => (x * Wa, y + e * A))
    line(..pts, stroke: if row.grid == "fine" { s-construct } else { s-interface })
    let r0 = if row.grid == "fine" { 0.3 } else { 0.55 }
    for p in pts { circle(p, radius: r0, fill: ink, stroke: none) }
    content((Wa + 2, y), anchor: "west", text(7pt, row.label))
  }
  content((Wa / 2, -4), anchor: "north", [(a)])

  // ---- (b) basis functions on two grid scales -----------------------------
  let proj(o, x, y, z) = (o.at(0) + x + 0.55 * y, o.at(1) + 0.38 * y + z * 13)
  let hat(t, c, w) = calc.max(0, 1 - calc.abs(t - c) / w)
  let surface(o, ax, ay, w) = {
    let N(x, y) = hat(x, ax, w) * hat(y, ay, w)
    for (di, dj) in ((-1, 0), (0, 0), (-1, -1), (0, -1)) {
      let (x1, y1) = (ax + di * w, ay + dj * w)
      let cs = ((x1, y1), (x1 + w, y1), (x1 + w, y1 + w), (x1, y1 + w))
      line(..cs.map(c => proj(o, c.at(0), c.at(1), N(c.at(0), c.at(1)))), close: true, fill: paper, stroke: none)
      for k in range(1, 4) {
        let t = k * w / 4
        line(proj(o, x1 + t, y1, N(x1 + t, y1)), proj(o, x1 + t, y1 + w, N(x1 + t, y1 + w)), stroke: s-construct)
        line(proj(o, x1, y1 + t, N(x1, y1 + t)), proj(o, x1 + w, y1 + t, N(x1 + w, y1 + t)), stroke: s-construct)
      }
      line(..cs.map(c => proj(o, c.at(0), c.at(1), N(c.at(0), c.at(1)))), close: true, stroke: s-interface)
    }
  }
  let grid(o, cell, nx, ny) = {
    for i in range(nx + 1) { line(proj(o, i * cell, 0, 0), proj(o, i * cell, ny * cell, 0), stroke: s-mesh) }
    for j in range(ny + 1) { line(proj(o, 0, j * cell, 0), proj(o, nx * cell, j * cell, 0), stroke: s-mesh) }
  }
  let oc = (84, 40)                 // coarse grid origin
  let of = (84, 6)                  // fine grid origin
  let (ax, ay) = (20, 10)           // the shared node, mm in the grid plane
  grid(of, 5, 8, 4)
  surface(of, ax, ay, 5)
  line(proj(of, ax, ay, 1), proj(oc, ax, ay, 0), stroke: (paint: mesh-grey, thickness: w-mesh, dash: "dotted"))
  grid(oc, 10, 4, 2)
  surface(oc, ax, ay, 10)
  content((oc.at(0) - 2, oc.at(1) + 3), anchor: "east", $H$)
  content((of.at(0) - 2, of.at(1) + 3), anchor: "east", $h$)
  content((of.at(0) + 26, -4), anchor: "north", [(b)])

  // ---- (c)-(e) cycle schedules ---------------------------------------------
  let dx = 2.5
  let dl = 3.6
  let schedule(o, seq, lab, fmg: false) = {
    let n = seq.len()
    let Wd = 15 * dx
    for lv in range(4) {
      line((o.at(0), o.at(1) + lv * dl), (o.at(0) + Wd, o.at(1) + lv * dl), stroke: (paint: mesh-grey, thickness: w-mesh, dash: "dashed"))
    }
    content((o.at(0) + Wd + 1.5, o.at(1) + 3 * dl), anchor: "west", text(7pt, [fine]))
    content((o.at(0) + Wd + 1.5, o.at(1)), anchor: "west", text(7pt, [coarse]))
    let pts = seq.enumerate().map(((k, lv)) => (o.at(0) + k * dx, o.at(1) + lv * dl))
    let top = seq.at(0)
    for k in range(n - 1) {
      let new-level = fmg and seq.at(k + 1) > calc.max(..seq.slice(0, k + 1))
      line(pts.at(k), pts.at(k + 1), stroke: if new-level { (paint: ink, thickness: w-boundary) } else { s-construct })
    }
    for p in pts { circle(p, radius: 0.55, fill: ink, stroke: none) }
    content((o.at(0) - 2, o.at(1) + 1.5 * dl), anchor: "east", lab)
  }
  schedule((138, 56), data.v, [(c)])
  schedule((138, 30), data.w, [(d)])
  schedule((138, 4), data.fmg, [(e)], fmg: true)
})
