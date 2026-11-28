// Shape functions beyond linear 1-D elements (fem-practice, fig-shape-functions).
// (a) Quadratic elements in 1-D: the function of a corner node (solid) is one
//     at its node, zero at the other nodes of both elements it belongs to, and
//     negative in between; the function of a mid-node (dashed) is a bubble
//     inside its own element.
// (b) Bilinear quadrilaterals in 2-D: the basis function of node A, drawn as a
//     ruled surface over the four cells that share A.
// Double column (183 mm).
//
// Build:  pixi run figures fem-shape-functions

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let node(p, r: 0.75, fill: ink) = circle(p, radius: r, fill: fill, stroke: (paint: ink, thickness: 0.5pt))

  // ---- (a) quadratic 1-D ----------------------------------------------------
  let L = 24          // element length, mm
  let H = 16          // unit height, mm
  let x0 = 0
  let y0 = 10
  line((x0 - 3, y0), (x0 + 3 * L + 3, y0), stroke: s-construct)
  // corner-node function at x = L (shared by elements [0, L] and [L, 2L])
  let corner(x) = {
    if x <= L { let s = x / L; s * (2 * s - 1) }
    else if x <= 2 * L { let s = (x - L) / L; (1 - s) * (1 - 2 * s) }
    else { 0 }
  }
  // mid-node function of element [2L, 3L]
  let bubble(x) = {
    if x >= 2 * L and x <= 3 * L { let s = (x - 2 * L) / L; 4 * s * (1 - s) } else { 0 }
  }
  let curve(f) = range(0, 241).map(k => { let x = k * 3 * L / 240; (x0 + x, y0 + H * f(x)) })
  line(..curve(corner), stroke: s-interface)
  line(..curve(bubble).filter(p => p.at(0) >= x0 + 2 * L), stroke: s-hidden)
  // nodes: element ends filled, mid-nodes open
  for k in range(7) {
    let x = x0 + k * L / 2
    node((x, y0), fill: if calc.even(k) { ink } else { paper })
  }
  content((x0 + L, y0 + H + 1.5), anchor: "south", $N_A$)
  content((x0 + 2.5 * L, y0 + H + 1.5), anchor: "south", $N_C$)
  content((x0 + L, y0 - 2), anchor: "north", $A$)
  content((x0 + 2.5 * L, y0 - 2), anchor: "north", $C$)
  line((x0 - 4, y0), (x0 - 4, y0 + H), ..a-dimension)
  content((x0 - 5, y0 + H / 2), anchor: "east", $1$)
  line((x0 - 5.5, y0 + H), (x0 + L, y0 + H), stroke: (paint: mesh-grey, thickness: w-mesh, dash: "dotted"))
  content((x0 + 1.5 * L, -6), anchor: "north", [(a) quadratic elements, 1-D])

  // ---- (b) bilinear 2-D, oblique projection ---------------------------------
  let s = 11                       // cell size, mm
  let ni = 6
  let nj = 4
  let (ai, aj) = (3, 2)            // node A
  let Hz = 20                      // unit height, mm
  let ox = 98
  let oy = -2
  let proj(x, y, z) = (ox + x * s + 0.55 * y * s, oy + 0.38 * y * s + z * Hz)
  let hat(t, c) = calc.max(0, 1 - calc.abs(t - c))
  let N(x, y) = hat(x, ai) * hat(y, aj)

  // support on the base plane
  line(proj(ai - 1, aj - 1, 0), proj(ai + 1, aj - 1, 0), proj(ai + 1, aj + 1, 0), proj(ai - 1, aj + 1, 0),
       close: true, fill: emphasis-tint, stroke: none)
  // base grid
  for i in range(ni + 1) { line(proj(i, 0, 0), proj(i, nj, 0), stroke: s-mesh) }
  for j in range(nj + 1) { line(proj(0, j, 0), proj(ni, j, 0), stroke: s-mesh) }
  // The surface over each of the four cells is bilinear, hence ruled: lines of
  // constant x and of constant y on it are straight. Cells are painted back to
  // front (larger y is further away) so the surface hides what is behind it.
  let cells = ((-1, 0), (0, 0), (-1, -1), (0, -1))     // (di, dj): back cells first
  for (di, dj) in cells {
    let (x1, y1) = (ai + di, aj + dj)
    let corners = ((x1, y1), (x1 + 1, y1), (x1 + 1, y1 + 1), (x1, y1 + 1))
    line(..corners.map(c => proj(c.at(0), c.at(1), N(c.at(0), c.at(1)))), close: true,
         fill: paper, stroke: none)
    for k in range(1, 4) {
      let t = k / 4
      line(proj(x1 + t, y1, N(x1 + t, y1)), proj(x1 + t, y1 + 1, N(x1 + t, y1 + 1)), stroke: s-construct)
      line(proj(x1, y1 + t, N(x1, y1 + t)), proj(x1 + 1, y1 + t, N(x1 + 1, y1 + t)), stroke: s-construct)
    }
    // cell outline on the surface
    line(..corners.map(c => proj(c.at(0), c.at(1), N(c.at(0), c.at(1)))), close: true, stroke: s-interface)
  }
  // node A is hidden under the apex: a leader along its grid line points to it
  line(proj(ai, aj - 1, 0), proj(ai, aj - 1.6, 0), stroke: (paint: mesh-grey, thickness: w-mesh, dash: "dotted"))
  content((proj(ai, aj, 1).at(0), proj(ai, aj, 1).at(1) + 1.5), anchor: "south", $N_A$)
  content((proj(ai, aj - 1.6, 0).at(0), proj(ai, aj - 1.6, 0).at(1) - 1), anchor: "north", $A$)
  content((ox + 0.5 * (ni * s + 0.55 * nj * s), -6), anchor: "north", [(b) bilinear elements, 2-D])
})
