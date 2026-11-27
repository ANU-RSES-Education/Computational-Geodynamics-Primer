// Marching through time (time-integration, fig-time-discretisation).
// The solution theta(t) of the decay equation is known only at discrete times
// separated by Delta t: theta_0, theta_1, ... theta_n, theta_(n+1).
// Single column (90 mm).
//
// Build:  pixi run figures time-marching

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let dt = 9                        // Delta t, mm
  let n = 8                         // steps shown
  let A = 30                        // theta_0, mm
  let k = 0.022                     // decay rate per mm of t
  let th(t) = A * calc.exp(-k * t) + 2
  let T = n * dt

  // axes
  line((0, 0), (T + 6, 0), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  content((T + 6.5, 0), anchor: "west", $t$)
  line((0, 0), (0, A + 8), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  content((0, A + 8.5), anchor: "south", $theta$)

  // the continuous solution
  let curve = range(0, 121).map(j => { let t = j * (T + 3) / 120; (t, th(t)) })
  line(..curve, stroke: s-construct)

  // discrete values
  for i in range(n + 1) {
    let t = i * dt
    line((t, 0), (t, th(t)), stroke: (paint: mesh-grey, thickness: w-mesh, dash: "dotted"))
    circle((t, th(t)), radius: 0.9, fill: ink, stroke: none)
  }
  let lab(i, body) = content((i * dt + 0.8, th(i * dt) + 1.2), anchor: "south-west", body)
  lab(0, $theta_0$)
  lab(1, $theta_1$)
  lab(2, $theta_2$)
  lab(n - 1, $theta_n$)
  lab(n, $theta_(n+1)$)
  content((4.5 * dt, th(4.5 * dt) + 4), $dots.h$)
  // one step
  line((2 * dt, -3), (3 * dt, -3), ..a-dimension)
  content((2.5 * dt, -4), anchor: "north", $Delta t$)
})
