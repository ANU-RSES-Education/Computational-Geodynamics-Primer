"""Streamlines of uniform potential flow past a circular cylinder.

Stream function psi = U y (1 - a^2 / r^2), with U = 1, a = 1. Streamlines are
traced as contours of psi in the upper half plane and mirrored. psi = 0 is the
dividing streamline: the x axis up to the stagnation point (-a, 0), then the
cylinder surface. Writes stagnation-point.json (lists of [x, y] in units of a).
"""
import json
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

x = np.linspace(-4.0, 3.0, 701)
y = np.linspace(0.0, 2.4, 241)
X, Y = np.meshgrid(x, y)
R2 = X**2 + Y**2
with np.errstate(divide="ignore", invalid="ignore"):
    psi = Y * (1 - 1 / R2)
psi[R2 < 1] = np.nan

levels = [0.12, 0.35, 0.7, 1.15, 1.7]
cs = plt.contour(X, Y, psi, levels=levels)
lines = []
for segs in cs.allsegs:
    for seg in segs:
        if len(seg) < 10:
            continue
        pts = seg[:: max(1, len(seg) // 120)]
        up = [[round(float(a), 3), round(float(b), 3)] for a, b in pts]
        lines.append(up)
        lines.append([[p[0], -p[1]] for p in up])

with open("stagnation-point.json", "w") as f:
    json.dump({"lines": lines}, f)
print(len(lines), "streamlines")
