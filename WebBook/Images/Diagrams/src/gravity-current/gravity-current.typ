// A viscous gravity current (stokes-flow-applications, fig-gravity-current).
// Constant-volume similarity solution of dh/dt = (g Drho / 3 eta) d/dx(h^3 dh/dx):
// h(x, t) = H(t) (1 - (x/x_N)^2)^(1/3), with front x_N ~ t^(1/5) and height
// H ~ t^(-1/5), so the area under each profile is the same. Profiles at
// t = 1, 3, 12, 50 (arbitrary units); the last is filled. On it, the
// horizontal velocity at one x is u ~ z (2h - z): zero at the base, no shear
// at the surface.
// Single column (90 mm).
//
// Build:  pixi run figures gravity-current

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let L0 = 18                    // front position at t = 1, mm
  let H0 = 26                    // height at t = 1, mm
  let prof(t) = {
    let xn = L0 * calc.pow(t, 0.2)
    let hh = H0 * calc.pow(t, -0.2)
    range(0, 81).map(j => { let x = j * xn / 80; (x, hh * calc.pow(calc.max(0, 1 - (x / xn) * (x / xn)), 1 / 3)) })
  }
  let ts = (1, 3, 12, 50)
  let last = prof(ts.at(3))
  line((0, 0), ..last, close: true, fill: fluid-tint, stroke: none)
  for t in ts.slice(0, 3) { line(..prof(t), stroke: s-construct) }
  line(..last, stroke: s-interface)

  // base and axes
  line((0, 0), (L0 * calc.pow(50, 0.2) + 10, 0), stroke: s-boundary)
  for k in range(int((L0 * calc.pow(50, 0.2) + 8) / 2.5)) {
    line((1 + k * 2.5, 0), (-0.8 + k * 2.5, -1.8), stroke: s-construct)
  }
  line((0, 0), (0, H0 + 5), stroke: s-construct, mark: (end: "stealth", fill: ink, scale: 0.4))
  content((0, H0 + 5.5), anchor: "south", $h$)
  content((L0 * calc.pow(50, 0.2) + 10.5, 0), anchor: "west", $x$)
  content((L0 * 0.55, H0 * 0.93), anchor: "south-west", $h(x, t)$)

  // velocity profile u ~ z (2h - z) at one x on the last profile
  let xn = L0 * calc.pow(50, 0.2)
  let hh = H0 * calc.pow(50, -0.2)
  let xu = 0.55 * xn
  let hu = hh * calc.pow(1 - 0.55 * 0.55, 1 / 3)
  line((xu, 0), (xu, hu), stroke: s-construct)
  let umax = 7
  let pts = ()
  for j in range(0, 6) {
    let z = j * hu / 5
    let u = umax * z * (2 * hu - z) / (hu * hu)
    pts.push((xu + u, z))
    if j > 0 { line((xu, z), (xu + u, z), ..a-velocity) }
  }
  line(..range(0, 21).map(j => { let z = j * hu / 20; (xu + umax * z * (2 * hu - z) / (hu * hu), z) }),
       stroke: (paint: velocity, thickness: w-construct))
  content((xu + umax + 1, hu - 1), anchor: "west", $u(z)$)
})
