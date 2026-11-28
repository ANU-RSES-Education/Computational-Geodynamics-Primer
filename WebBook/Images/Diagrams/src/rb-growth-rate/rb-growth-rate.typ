// Growth rate of harmonic perturbations in a layer heated from below
// (rayleigh-benard-convection, fig-critical-ra). From the linear stability
// result sigma = k^2 Ra / (pi^2 + k^2)^2 - (pi^2 + k^2) (free-slip
// boundaries), plotted against wavenumber k for several Ra. The critical
// curve, Ra_c = 27 pi^4 / 4 = 657.5 (accent), just touches sigma = 0 at
// k_c = pi / sqrt(2).
// Single column (90 mm).
//
// Build:  pixi run figures rb-growth-rate

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let sx = 11.0                   // mm per unit k
  let sy = 0.85                   // mm per unit sigma
  let (kmax, smin, smax) = (6.0, -50.0, 22.0)
  let pi2 = calc.pi * calc.pi
  let growth(k, Ra) = k * k * Ra / calc.pow(pi2 + k * k, 2) - (pi2 + k * k)
  let P(k, s) = (k * sx, s * sy)
  let Rac = 27 * pi2 * pi2 / 4
  let kc = calc.pi / calc.sqrt(2)
  let small(pos, body, anchor: "center") = content(pos, anchor: anchor, text(7pt, body))

  // axes
  line(P(0, smin), P(0, smax), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  line(P(0, smin), P(kmax + 0.3, smin), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  line(P(0, 0), P(kmax, 0), stroke: (paint: mesh-grey, thickness: w-mesh, dash: "dotted"))
  for k in range(0, 7) {
    line(P(k, smin), (k * sx, smin * sy - 1), stroke: s-construct)
    small((k * sx, smin * sy - 1.5), str(k), anchor: "north")
  }
  for s in (-40, -20, 0, 20) {
    line(P(0, s), (-1, s * sy), stroke: s-construct)
    small((-1.5, s * sy), str(s), anchor: "east")
  }
  content(P(kmax + 0.4, smin), anchor: "west", $k$)
  content(P(0, smax + 1), anchor: "south", $sigma$)

  // curves
  let curve(Ra) = range(1, 121).map(j => { let k = j * kmax / 120; P(k, calc.max(growth(k, Ra), smin)) })
  for Ra in (100, 300, 1000, 1400) {
    line(..curve(Ra), stroke: s-construct)
    let k = 2.9
    small((k * sx + 1, growth(k, Ra) * sy + 1.2), $"Ra" = #Ra$, anchor: "south-west")
  }
  line(..curve(Rac), stroke: (paint: accent, thickness: w-boundary))
  circle(P(kc, 0), radius: 0.9, fill: accent, stroke: none)
  small((kc * sx - 1, 2.0), text(fill: accent, $"Ra"_c = 657.5$), anchor: "south-east")
  line(P(kc, 0), P(kc, smin), stroke: (paint: accent, thickness: w-mesh, dash: "dotted"))
  small((kc * sx + 0.8, smin * sy + 1.5), $k_c = pi \/ sqrt(2)$, anchor: "south-west")
})
