// Second-order Runge-Kutta (midpoint) step for d theta / dt = -k theta
// (time-integration, fig-rk2).
// Stage 1: an Euler half-step along the tangent at t gives the estimate
//          theta-hat at t + Delta t / 2 (dashed).
// Stage 2: the gradient evaluated at theta-hat (short segment there) is used
//          for the whole step from theta(t), giving theta(t + Delta t).
// The step is large (k Delta t = 0.8) so that the error is visible.
// Single column (90 mm).
//
// Build:  pixi run figures time-rk2

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let sx = 60                      // mm per unit time
  let sy = 34                      // mm per unit theta
  let k = 1.0
  let dt = 0.8
  let P(t, th) = (t * sx, th * sy)
  let exact(t) = calc.exp(-k * t)

  // axes
  line((0, 0), (1.25 * sx, 0), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  content((1.25 * sx + 0.5, 0), anchor: "west", $t$)
  line((0, 0), (0, 1.15 * sy), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  content((0, 1.15 * sy + 0.5), anchor: "south", $theta$)

  // exact solution
  line(..range(0, 101).map(j => { let t = j * 1.15 / 100; P(t, exact(t)) }), stroke: s-construct)

  // stage 1: Euler half-step
  let th0 = 1.0
  let thhat = th0 * (1 - k * dt / 2)
  line(P(0, th0), P(dt / 2, thhat), stroke: s-hidden)
  // stage 2: gradient at the midpoint estimate, applied over the whole step
  let g = -k * thhat
  let th1 = th0 + g * dt
  let d = 0.09
  line(P(dt / 2 - d, thhat - g * d), P(dt / 2 + d, thhat + g * d), stroke: s-interface)
  line(P(0, th0), P(dt, th1), stroke: s-interface, mark: (end: "stealth", fill: ink, scale: 0.5))

  // guides and ticks
  for (t, lab) in ((0, $t$), (dt / 2, $t + Delta t\/2$), (dt, $t + Delta t$)) {
    line(P(t, 0), P(t, 1.05), stroke: (paint: mesh-grey, thickness: w-mesh, dash: "dotted"))
    content((t * sx, -1.5), anchor: "north", lab)
  }

  // points
  circle(P(0, th0), radius: 1, fill: ink, stroke: none)
  circle(P(dt / 2, thhat), radius: 1, fill: paper, stroke: s-interface)
  circle(P(dt, th1), radius: 1, fill: ink, stroke: none)
  circle(P(dt, exact(dt)), radius: 0.7, fill: paper, stroke: s-construct)
  content((1.5, th0 * sy + 1.5), anchor: "south-west", $theta(t)$)
  content((dt / 2 * sx - 1.5, thhat * sy - 1.5), anchor: "north-east", $hat(theta)$)
  content((dt * sx + 1.5, th1 * sy + 0.5), anchor: "west", [$theta(t + Delta t)$, RK2])
  content((dt * sx + 1.2, exact(dt) * sy - 1.2), anchor: "north-west", [exact])
})
