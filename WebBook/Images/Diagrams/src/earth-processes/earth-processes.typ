// The Earth's interior and the processes that move heat through it
// (index, fig-mantle-slice). A wedge of the Earth, radii to scale.
// Background: the temperature in the mantle (earth-processes.py), cold side as
// in the annulus subduction models' initial state: half-space-cooled plates and
// a slab cooled from the plate age continued down the fault plane; hot side a
// basal layer (D'') and a plume. The cold outline is T = 0.9 T_i (the base of
// the thermal lithosphere and the slab); the hot outline is T_i + 0.06.
// Lithosphere is about 2.5 times too thick, as in the models.
// Overriding plate: oceanic near the trench, then a continent (with crust,
// drawn as a compositional layer) and a thicker cratonic keel.
// Overlaid: the 660 km phase change (dashed), convection (velocity arrows),
// core, labels.
// Double column (183 mm).
//
// Build:  pixi run figures earth-processes   (runs earth-processes.py first)

#import "../primerfig.typ": *
#show: fig-setup
#let data = json("earth-processes.json")
#let field = if theme-name == "dark" { "earth-processes-field-dark.png" } else { "earth-processes-field-light.png" }

#cetz.canvas(length: 1mm, {
  import cetz.draw: *

  let s = 64 / 6370                      // mm per km
  let P(r, th) = (r * s * calc.cos(th * 1deg), r * s * calc.sin(th * 1deg))
  let arcpts(r, t1, t2, n: 60) = range(0, n + 1).map(k => P(r, t1 + (t2 - t1) * k / n))
  let (t-left, t-right) = (145, 35)
  let (Rs, R660, Rcmb, Ric) = (6370, 5710, 3480, 1220)
  let label(pos, body, anchor: "center") = content(pos, anchor: anchor, text(7pt, body))
  let (x0, y0, x1, y1) = data.extent

  // core
  line((0, 0), ..arcpts(Rcmb, t-left, t-right), close: true, fill: fluid-tint, stroke: none)
  line((0, 0), ..arcpts(Ric, t-left, t-right), close: true, fill: solid-tint, stroke: none)
  // mantle temperature
  content((x0, y0), anchor: "south-west", image(field, width: (x1 - x0) * 1mm))
  // thermal outlines from the field
  for c in data.cold { line(..c, stroke: (paint: ink, thickness: w-interface)) }
  for c in data.hot { line(..c, stroke: (paint: energy, thickness: w-interface)) }
  // continental crust: a compositional layer, drawn over the field
  line(..data.crust, close: true, fill: ink.transparentize(58%), stroke: none)
  line(..data.crust_base, stroke: s-interface)
  // structure
  line(..arcpts(R660, t-left, t-right), stroke: (paint: ink, thickness: w-construct, dash: "dashed"))
  line(..arcpts(Rcmb, t-left, t-right), stroke: s-boundary)
  line(..arcpts(Ric, t-left, t-right), stroke: s-interface)
  line(..arcpts(Rs, t-left, t-right), stroke: s-boundary)
  line(P(0, 0), P(Rs, t-left), stroke: s-interface)
  line(P(0, 0), P(Rs, t-right), stroke: s-interface)

  // convection: rising beside the plume, sinking beside the slab
  let cell(rc, tc, dr, dt, a0, a1) = {
    let pts = range(0, 41).map(k => {
      let a = (a0 + (a1 - a0) * k / 40) * 1deg
      P(rc + dr * calc.sin(a), tc + dt * calc.cos(a))
    })
    line(..pts, stroke: (paint: velocity, thickness: 0.9pt), mark: (end: "stealth", fill: velocity, scale: 0.5))
  }
  cell(4650, 100, 620, 11, 200, 470)
  cell(4600, 52, 560, 8, 250, -20)

  // labels
  label(P(Rs + 700, 124), [oceanic lithosphere], anchor: "south")
  label(P(Rs + 700, 64), [continental crust], anchor: "south")
  label(P(Rs + 700, 46.5), [craton], anchor: "south")
  label(P(Rs + 260, 80), [trench], anchor: "south")
  label(P(5200, 64.5), [slab])
  label(P(4500, 128.5), [plume])
  label(P(3900, 111), [mantle])
  label(P(2400, 108), [outer core])
  label(P(650, 90), [inner core])
  label(P(Rcmb + 260, 44), $D''$, anchor: "south")
  label(P(R660, t-right - 1), [660 km], anchor: "west")
  let off(p, d) = (p.at(0) - d * calc.sin(t-left * 1deg), p.at(1) + d * calc.cos(t-left * 1deg))
  line(off(P(0, 0), 4), off(P(Rs, t-left), 4), ..a-dimension)
  label(off(P(Rs / 2, t-left), 6.5), [6370 km], anchor: "east")
  line(off(P(Rcmb, t-left), -3.5), off(P(Rs, t-left), -3.5), stroke: (paint: ink, thickness: 0.5pt),
       mark: (start: "stealth", end: "stealth", fill: ink, scale: 0.4))
  label(off(P((Rcmb + Rs) / 2, t-left), -5.5), [2900 km], anchor: "west")
})
