"""Data for the multigrid figure: one two-level V cycle and three cycle schedules.

Panel (a) follows the error e (not the solution) through one two-level V cycle
for the 1-D Poisson problem -u'' = f on a fine grid of 32 intervals:
  1. initial error: smooth components plus high-wavenumber noise
  2. after 3 weighted-Jacobi sweeps (omega = 2/3): the noise is removed
  3. the smoothed error restricted to the coarse grid (full weighting)
  4. the coarse-grid correction: the coarse problem for the restricted
     residual, solved exactly on 16 intervals
  5. after interpolating the correction back and subtracting it
  6. after 3 more Jacobi sweeps
All rows share one scale (max |e| of row 1 = 1).

Panels (c)-(e) are the level sequences of V, W and full-multigrid cycles on
four levels (3 = finest, 0 = coarsest).

Writes multigrid.json beside this file.
"""
import json
import numpy as np

N = 32                      # fine intervals
n = N - 1                   # interior fine nodes
x = np.linspace(0, 1, N + 1)


def poisson(m):
    """Second-difference operator (-u'') on m interior nodes, unit interval."""
    h = 1 / (m + 1)
    return (2 * np.eye(m) - np.eye(m, k=1) - np.eye(m, k=-1)) / h**2


def jacobi(A, e, sweeps, omega=2 / 3):
    D = np.diag(A)
    for _ in range(sweeps):
        e = e - omega * (A @ e) / D          # error equation A e = 0
    return e


def restrict(v):
    """Full weighting from n = 2m+1 fine interior nodes to m coarse ones."""
    return 0.25 * v[0:-2:2] + 0.5 * v[1:-1:2] + 0.25 * v[2::2]


def prolong(vc):
    """Linear interpolation from m coarse interior nodes to 2m+1 fine ones."""
    m = len(vc)
    vf = np.zeros(2 * m + 1)
    vf[1::2] = vc
    padded = np.concatenate(([0.0], vc, [0.0]))
    vf[0::2] = 0.5 * (padded[:-1] + padded[1:])
    return vf


rng = np.random.default_rng(3)
xi = x[1:-1]
e0 = 0.55 * np.sin(np.pi * xi) + 0.25 * np.sin(3 * np.pi * xi) + 0.35 * rng.uniform(-1, 1, n)

Af = poisson(n)
Ac = poisson((n - 1) // 2)

e1 = jacobi(Af, e0, 3)
r_c = restrict(Af @ e1)                    # residual of the error equation, coarse
ec = np.linalg.solve(Ac, r_c)              # coarse-grid correction (exact solve)
e2 = e1 - prolong(ec)
e3 = jacobi(Af, e2, 3)

scale = np.max(np.abs(e0))


def full(v):
    return [0.0] + list(np.round(v / scale, 4)) + [0.0]


xc = np.linspace(0, 1, (n - 1) // 2 + 2)


def v_cycle(level):
    return [level] if level == 0 else [level] + v_cycle(level - 1) + [level]


def merge(seq):
    """Drop consecutive repeats: arriving at a level and starting from it are one step."""
    out = []
    for s in seq:
        if not out or out[-1] != s:
            out.append(s)
    return out


def w_cycle(level):
    """Visit the next-coarser level twice: W(l) = l, W(l-1), W(l-1), l."""
    if level == 0:
        return [0]
    inner = w_cycle(level - 1)
    return merge([level] + inner + inner + [level])


def fmg(levels):
    seq = [0]
    for lv in range(1, levels):
        seq += v_cycle(lv)            # interpolate up to the new level, then a V cycle
    return seq


data = {
    "fine_x": list(np.round(x, 4)),
    "coarse_x": list(np.round(xc, 4)),
    "rows": [
        {"grid": "fine", "label": "error", "e": full(e0)},
        {"grid": "fine", "label": "smoothed", "e": full(e1)},
        {"grid": "coarse", "label": "on coarse grid", "e": [0.0] + list(np.round(restrict(e1) / scale, 4)) + [0.0]},
        {"grid": "coarse", "label": "coarse correction", "e": [0.0] + list(np.round(ec / scale, 4)) + [0.0]},
        {"grid": "fine", "label": "corrected", "e": full(e2)},
        {"grid": "fine", "label": "smoothed again", "e": full(e3)},
    ],
    "v": v_cycle(3),
    "w": w_cycle(3),
    "fmg": fmg(4),
}
with open("multigrid.json", "w") as f:
    json.dump(data, f)
print("max |e| per row:", [round(float(np.max(np.abs(np.array(r["e"])))), 3) for r in data["rows"]])
print("V", data["v"]); print("W", data["w"]); print("FMG", data["fmg"])
