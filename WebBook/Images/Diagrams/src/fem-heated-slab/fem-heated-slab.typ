// One-dimensional heat conduction in a slab (fem-introduction, fig-heated-bar).
// A heat flux Q enters the face x = 0 from time t = 0; the face x = L is held
// at temperature theta_i; heat is generated inside at rate q^B. The slab is
// unbounded in the directions across the page, so the problem depends on x only.
// Single column (90 mm).
//
// Build:  pixi run figures fem-heated-slab

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let L = 46
  let H = 30
  // slab, with break lines top and bottom: it continues beyond the page
  rect((0, 0), (L, H), fill: solid-tint, stroke: none)
  line((0, 0), (0, H), stroke: s-boundary)
  line((L, 0), (L, H), stroke: s-boundary)
  for y in (0, H) {
    line((-2, y), (L + 2, y), stroke: (paint: ink, thickness: w-construct, dash: "dashed"))
  }
  // fixed temperature at x = L: hatched contact on the outside
  for k in range(11) {
    let y = 1.5 + k * 2.7
    line((L, y), (L + 2.2, y + 2.2), stroke: s-construct)
  }
  content((L + 4, H / 2), anchor: "west", $theta = theta_i$)
  // heat flux into the face x = 0
  for y in (7, 15, 23) {
    line((-13, y), (-1, y), ..a-energy)
  }
  content((-13, 27), anchor: "south-west", $Q$)
  // internal heat generation
  content((L / 2, H / 2), $q^B$)
  // axis and dimension
  line((0, -5), (L + 8, -5), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  content((L + 8.5, -5), anchor: "west", $x$)
  for (x, lab) in ((0, $0$), (L, $L$)) {
    line((x, -6), (x, -4), stroke: s-construct)
    content((x, -7), anchor: "north", lab)
  }
})
