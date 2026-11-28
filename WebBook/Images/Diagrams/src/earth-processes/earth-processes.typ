// The Earth's interior and the processes that move heat through it
// (index, fig-mantle-slice). A wedge of the Earth, radii to scale except the
// lithosphere, which is drawn about 2.5 times too thick to be visible:
//   oceanic lithosphere subducting at a trench beneath continental
//   lithosphere (with crust); the slab descending into the mantle; a plume
//   rising from the D'' layer above the core-mantle boundary and spreading
//   beneath the plate; convection in the mantle (velocity arrows); the 660 km
//   phase change (dashed); outer and inner core.
// Double column (183 mm).
//
// Build:  pixi run figures earth-processes

#import "../primerfig.typ": *
#show: fig-setup

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let s = 64 / 6370                      // mm per km
  let P(r, th) = (r * s * calc.cos(th * 1deg), r * s * calc.sin(th * 1deg))
  let arcpts(r, t1, t2, n: 60) = range(0, n + 1).map(k => P(r, t1 + (t2 - t1) * k / n))
  let (t-left, t-right) = (145, 35)      // wedge edges, degrees
  let (Rs, R660, Rdpp, Rcmb, Ric) = (6370, 5710, 3680, 3480, 1220)
  let label(pos, body, anchor: "center") = content(pos, anchor: anchor, text(7pt, body))

  // ---- shells ---------------------------------------------------------------
  line((0, 0), ..arcpts(Rs, t-left, t-right), close: true, fill: solid-tint, stroke: none)
  line((0, 0), ..arcpts(Rcmb, t-left, t-right), close: true, fill: fluid-tint, stroke: none)
  line((0, 0), ..arcpts(Ric, t-left, t-right), close: true, fill: solid-tint, stroke: none)
  line(..arcpts(Rcmb, t-left, t-right), stroke: s-boundary)
  line(..arcpts(Ric, t-left, t-right), stroke: s-interface)
  line(..arcpts(R660, t-left, t-right), stroke: (paint: ink, thickness: w-construct, dash: "dashed"))
  line(..arcpts(Rdpp, t-left, t-right), stroke: (paint: ink, thickness: w-construct, dash: "dotted"))

  // ---- lithosphere and slab (cold, stiff: neutral tint) ----------------------
  let Ho = 260                           // oceanic plate, km (exaggerated)
  let Hc = 420                           // continental plate, km (exaggerated)
  let trench = 80
  let cold = ink.transparentize(72%)
  // oceanic plate, bending down into the slab at the trench
  let top = arcpts(Rs, t-left, trench, n: 40) + ((6150, 78.2), (5800, 75.8), (5400, 74.2), (4950, 73.3), (4700, 73.0)).map(((r, t)) => P(r, t))
  let bot = arcpts(Rs - Ho, t-left, trench + 0.6, n: 40) + ((5860, 78.6), (5480, 76.9), (5040, 75.8), (4720, 75.3)).map(((r, t)) => P(r, t))
  line(..top, P(4600, 74.1), ..bot.rev(), close: true, fill: cold, stroke: none)
  line(..top, stroke: s-interface)
  line(..bot, stroke: s-interface)
  line(top.last(), P(4600, 74.1), bot.last(), stroke: s-interface)
  // continental plate and crust
  // its landward edge rests on the top of the slab, which passes beneath it
  let cont = arcpts(Rs, trench - 0.4, t-right, n: 40)
  let cbase = arcpts(Rs - Hc, t-right, 77.4, n: 40)
  line(..cont, ..cbase, P(6150, 78.2), close: true, fill: cold, stroke: none)
  line(..cbase, stroke: s-interface)
  line(..cont, ..arcpts(Rs - 110, t-right, trench - 0.9, n: 30), close: true, fill: ink.transparentize(55%), stroke: none)

  // ---- plume (hot: energy tint) ----------------------------------------------
  let hot = energy.transparentize(65%)
  let tail = (range(0, 21).map(k => { let r = Rdpp + (5880 - Rdpp) * k / 20; P(r, 124.8 - 5.6 * k / 20) }))
  let tail2 = (range(0, 21).map(k => { let r = Rdpp + (5880 - Rdpp) * k / 20; P(r, 122.6 - 5.6 * k / 20) }))
  line(..tail, ..tail2.rev(), close: true, fill: hot, stroke: none)
  line(..tail, stroke: (paint: energy, thickness: w-construct))
  line(..tail2, stroke: (paint: energy, thickness: w-construct))
  // head, flattened beneath the plate
  let hc = (Rs - Ho - 170)
  let head = range(0, 61).map(k => {
    let a = k * 6deg
    P(hc + 150 * calc.sin(a), 118.6 + 5.2 * calc.cos(a))
  })
  line(..head, close: true, fill: hot, stroke: (paint: energy, thickness: w-interface))

  // ---- convection ------------------------------------------------------------
  let cell(rc, tc, dr, dt, a0, a1) = {
    let pts = range(0, 41).map(k => {
      let a = (a0 + (a1 - a0) * k / 40) * 1deg
      P(rc + dr * calc.sin(a), tc + dt * calc.cos(a))
    })
    line(..pts, stroke: (paint: velocity, thickness: 0.9pt), mark: (end: "stealth", fill: velocity, scale: 0.5))
  }
  cell(4650, 98, 620, 11, 200, 470)
  cell(4600, 52, 560, 8, 250, -20)     // sinks beside the slab, flows toward it at the top

  // ---- surface and wedge edges ---------------------------------------------------
  line(..arcpts(Rs, t-left, t-right), stroke: s-boundary)
  line(P(0, 0), P(Rs, t-left), stroke: s-interface)
  line(P(0, 0), P(Rs, t-right), stroke: s-interface)

  // ---- labels ---------------------------------------------------------------------
  label(P(Rs + 700, 124), [oceanic lithosphere], anchor: "south")
  label(P(Rs + 700, 57), [continental lithosphere], anchor: "south")
  label(P(Rs + 260, trench), [trench], anchor: "south")
  label(P(4300, 73.5), [slab])
  label(P(4850, 126.5), [plume])
  label(P(3880, 111), [mantle])
  label(P(2400, 108), [outer core])
  label(P(650, 90), [inner core])
  label(P(Rcmb + 110, 43), $D''$, anchor: "south")
  label(P(R660, t-right - 1), [660 km], anchor: "west")
  // radius and depth of the core-mantle boundary, along the left edge
  let off(p, d) = (p.at(0) - d * calc.sin(t-left * 1deg), p.at(1) + d * calc.cos(t-left * 1deg))
  line(off(P(0, 0), 4), off(P(Rs, t-left), 4), ..a-dimension)
  label(off(P(Rs / 2, t-left), 6.5), [6370 km], anchor: "east")
  line(off(P(Rcmb, t-left), -3.5), off(P(Rs, t-left), -3.5), stroke: (paint: ink, thickness: 0.5pt),
       mark: (start: "stealth", end: "stealth", fill: ink, scale: 0.4))
  label(off(P((Rcmb + Rs) / 2, t-left), -5.5), [2900 km], anchor: "west")
})
