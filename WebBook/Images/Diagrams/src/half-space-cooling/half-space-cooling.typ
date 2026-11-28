// Cooling of a half space (rayleigh-benard-convection, fig-cooling-half-space).
// Initially at T_0 throughout, the surface held at T_s from t = 0: the
// dimensionless temperature (T - T_s)/(T_0 - T_s) = erf(z / 2 sqrt(kappa t)),
// plotted against depth at four times (kappa t = 10^-3, 10^-2, 10^-1, 1, in
// units of the depth shown squared). The cooled layer thickens as sqrt(t).
// Single column (90 mm).
//
// Build:  pixi run figures half-space-cooling

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let W = 52                         // temperature axis length
  let D = 46                         // depth axis length
  let small(pos, body, anchor: "center") = content(pos, anchor: anchor, text(7.5pt, body))
  let P(T, z) = (T * W, -z * D)      // depth increases downward

  // axes: temperature along the top, depth down the left
  line(P(0, 0), P(1.1, 0), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  line(P(0, 0), P(0, 1.08), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  small((1.1 * W + 1, 0), $(T - T_s) \/ (T_0 - T_s)$, anchor: "west")
  small((0, -1.08 * D - 1), $z$, anchor: "north")
  for T in (0, 0.5, 1) {
    line(P(T, 0), (T * W, 1), stroke: s-construct)
    small((T * W, 1.5), str(T), anchor: "south")
  }
  line(P(1, 0), P(1, 1.05), stroke: (paint: mesh-grey, thickness: w-mesh, dash: "dotted"))

  for (i, kt) in (0.001, 0.01, 0.1, 1.0).enumerate() {
    let pts = range(0, 121).map(j => { let z = j * 1.05 / 120; P(erf(z / (2 * calc.sqrt(kt))), z) })
    line(..pts, stroke: if i == 3 { s-interface } else { s-construct })
    // label beside the T = 1 line, level with where the profile reaches 0.95
    let z95 = 1.3859 * 2 * calc.sqrt(kt)
    if z95 < 1.0 {
      small((W + 1.5, -z95 * D), $kappa t = #kt$, anchor: "west")
    } else {
      small((erf(1.05 / (2 * calc.sqrt(kt))) * W + 1.5, -1.05 * D), $kappa t = #kt$, anchor: "west")
    }
  }
})
