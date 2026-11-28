// The Coulomb failure envelope and pore pressure (stress-and-faulting,
// fig-mohr-coulomb). Envelope tau = C + mu sigma_n with mu = 0.6 (phi = 31 deg).
// Solid circle: a stable state below the envelope. Dashed circle: the same
// state with pore pressure p_f, shifted left by p_f until it touches the
// envelope; the radius to the contact point makes 2 theta = 90 + phi with the
// sigma_n axis, measured from sigma_1. Compression positive.
// Single column (90 mm).
//
// Build:  pixi run figures mohr-coulomb

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let mu = 0.6
  let phi-ang = calc.atan(mu)
  let C = 8.0
  let R = 22.0                                   // circle radius (stress units)
  let k = 0.62                                   // mm per unit
  let small(pos, body, anchor: "center") = content(pos, anchor: anchor, text(7.5pt, body))
  let X(s) = k * s
  let Y(t) = k * t
  // centre where the circle just touches: distance from centre to the line = R
  // line: mu s - t + C = 0  ->  (mu c + C) / sqrt(1 + mu^2) = R
  let c-touch = (R * calc.sqrt(1 + mu * mu) - C) / mu
  let pf = 18.0
  let c0 = c-touch + pf

  // axes
  line((X(-6), 0), (X(c0 + R + 12), 0), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  line((0, Y(-4)), (0, Y(R + 22)), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  content((X(c0 + R + 12) + 1, 0), anchor: "west", $sigma_n$)
  content((0, Y(R + 22) + 1), anchor: "south", $tau$)
  // envelope
  let smax = c0 + R + 8
  line((0, Y(C)), (X(smax), Y(C + mu * smax)), stroke: s-boundary)
  small((X(smax) - 2, Y(C + mu * smax) + 1), $tau = C + mu sigma_n$, anchor: "south-east")
  small((-1.2, Y(C)), $C$, anchor: "east")
  // phi-ang: the envelope's inclination, against a horizontal reference
  let s2 = 0.18 * smax
  let Q = (X(s2), Y(C + mu * s2))
  line(Q, (Q.at(0) + 11, Q.at(1)), stroke: (paint: mesh-grey, thickness: w-mesh, dash: "dotted"))
  arc(Q, start: 0deg, stop: phi-ang, radius: 8, anchor: "origin", stroke: s-construct)
  small((Q.at(0) + 9, Q.at(1) + 2.2), $phi$, anchor: "west")
  // circles
  circle((X(c0), 0), radius: k * R, stroke: s-interface)
  circle((X(c-touch), 0), radius: k * R, stroke: (paint: ink, thickness: w-interface, dash: "dashed"))
  // contact point and 2 theta
  let ang = 90deg + phi-ang
  let P = (X(c-touch) + k * R * calc.cos(ang), k * R * calc.sin(ang))
  line((X(c-touch), 0), P, stroke: s-construct)
  arc((X(c-touch), 0), start: 0deg, stop: ang, radius: 5, anchor: "origin", stroke: s-construct)
  small((X(c-touch) + 3.2, 5.2), $2 theta$, anchor: "west")
  circle(P, radius: 0.9, fill: ink, stroke: none)
  // pore-pressure shift
  line((X(c0), Y(-R - 3)), (X(c-touch), Y(-R - 3)), stroke: (paint: ink, thickness: 0.6pt),
       mark: (end: "stealth", fill: ink, scale: 0.45))
  small(((X(c0) + X(c-touch)) / 2, Y(-R - 3) - 1), $p_f$, anchor: "north")
  // principal stresses of the stable state
  for (s, lab) in ((c0 - R, $sigma_3$), (c0 + R, $sigma_1$)) {
    circle((X(s), 0), radius: 0.7, fill: ink, stroke: none)
    small((X(s) + 1, -1.2), lab, anchor: "north-west")
  }
})
