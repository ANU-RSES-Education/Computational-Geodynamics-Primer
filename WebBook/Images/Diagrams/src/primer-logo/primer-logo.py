"""Geometry for the book logo: an icosahedral grid on a sphere under the continents.

Near-side perspective view (viewpoint 0.8 radii above the surface) centred
south-east of Australia, so the visible cap is about 56 degrees: Australia,
New Zealand and the Antarctic coast, with mainland Asia beyond the horizon. The grid is an icosahedron refined
twice (162 vertices) and pushed out to the sphere; only edges on the visible
hemisphere are kept. Coastlines are simplified by hand (lon, lat in degrees):
Australia, Tasmania, New Guinea, New Zealand, Antarctica. Writes primer-logo.json with everything in
units of the sphere radius.
"""
import json
import math
import numpy as np

LON0, LAT0 = 150.0, -40.0           # view centre
PV = 1.8                            # distance of the viewpoint from the centre, radii
LIMB = math.sqrt((PV - 1) / (PV + 1))


def project(lon, lat):
    """Near-side perspective; returns x, y scaled so the horizon has radius 1,
    and a visibility margin (> 0 on the visible cap)."""
    lam, phi = math.radians(lon - LON0), math.radians(lat)
    phi0 = math.radians(LAT0)
    cosc = math.sin(phi0) * math.sin(phi) + math.cos(phi0) * math.cos(phi) * math.cos(lam)
    xo = math.cos(phi) * math.sin(lam)
    yo = math.cos(phi0) * math.sin(phi) - math.sin(phi0) * math.cos(phi) * math.cos(lam)
    vis = cosc - 1 / PV
    if vis > 0:
        k = (PV - 1) / (PV - cosc) / LIMB
        return xo * k, yo * k, vis
    r = math.hypot(xo, yo) or 1.0        # beyond the horizon: pin to the limb
    return xo / r, yo / r, vis


# ---- icosphere -----------------------------------------------------------------
t = (1 + 5 ** 0.5) / 2
V = [(-1, t, 0), (1, t, 0), (-1, -t, 0), (1, -t, 0), (0, -1, t), (0, 1, t),
     (0, -1, -t), (0, 1, -t), (t, 0, -1), (t, 0, 1), (-t, 0, -1), (-t, 0, 1)]
V = [np.array(v, float) / np.linalg.norm(v) for v in V]
F = [(0, 11, 5), (0, 5, 1), (0, 1, 7), (0, 7, 10), (0, 10, 11), (1, 5, 9), (5, 11, 4),
     (11, 10, 2), (10, 7, 6), (7, 1, 8), (3, 9, 4), (3, 4, 2), (3, 2, 6), (3, 6, 8),
     (3, 8, 9), (4, 9, 5), (2, 4, 11), (6, 2, 10), (8, 6, 7), (9, 8, 1)]

for _ in range(2):
    cache, F2 = {}, []

    def mid(a, b):
        key = (min(a, b), max(a, b))
        if key not in cache:
            m = V[a] + V[b]
            V.append(m / np.linalg.norm(m))
            cache[key] = len(V) - 1
        return cache[key]

    for a, b, c in F:
        ab, bc, ca = mid(a, b), mid(b, c), mid(c, a)
        F2 += [(a, ab, ca), (b, bc, ab), (c, ca, bc), (ab, bc, ca)]
    F = F2

# rotate so the grid does not line up with the view axis
R = np.array([[math.cos(0.35), -math.sin(0.35), 0], [math.sin(0.35), math.cos(0.35), 0], [0, 0, 1]])
lonlat = []
for v in V:
    w = R @ v
    lonlat.append((math.degrees(math.atan2(w[1], w[0])), math.degrees(math.asin(w[2]))))

edges = set()
for a, b, c in F:
    for p, q in ((a, b), (b, c), (c, a)):
        edges.add((min(p, q), max(p, q)))

grid = []
for p, q in edges:
    # draw each edge as a short great-circle arc so it follows the sphere
    pts = []
    for s in np.linspace(0, 1, 5):
        w = (1 - s) * (R @ V[p]) + s * (R @ V[q])
        w /= np.linalg.norm(w)
        x, y, cosc = project(math.degrees(math.atan2(w[1], w[0])), math.degrees(math.asin(w[2])))
        pts.append((x, y, cosc))
    if min(c for _, _, c in pts) > 0.01:
        grid.append([[round(x, 4), round(y, 4)] for x, y, _ in pts])

# ---- coastlines (simplified) -----------------------------------------------------
australia = [(113.5, -22), (114.2, -26.5), (115.0, -34.0), (118.0, -35.0), (123.5, -33.9),
             (129.0, -31.6), (131.5, -31.5), (134.2, -32.8), (135.9, -34.8), (137.8, -33.0),
             (137.6, -35.6), (140.0, -37.9), (143.5, -38.8), (146.4, -39.1), (149.9, -37.5),
             (151.2, -33.9), (153.2, -30.5), (153.6, -28.2), (153.1, -25.2), (150.8, -22.5),
             (149.0, -20.9), (146.3, -18.9), (145.4, -16.0), (145.3, -14.9), (143.8, -14.0),
             (142.5, -10.7), (141.6, -12.9), (141.5, -16.5), (139.5, -17.4), (137.5, -16.0),
             (135.5, -14.9), (136.8, -12.3), (135.9, -11.9), (132.6, -11.5), (131.0, -12.2),
             (129.5, -14.9), (128.0, -15.4), (126.8, -13.9), (125.2, -14.6), (123.6, -16.6),
             (122.2, -17.9), (121.2, -19.5), (118.8, -20.3), (116.7, -20.6), (114.6, -21.8)]
tasmania = [(144.6, -40.7), (146.6, -41.1), (148.3, -40.9), (148.1, -42.3), (147.2, -43.3),
            (146.0, -43.5), (145.2, -42.2), (144.6, -41.2)]
new_guinea = [(131.0, -1.4), (132.4, -0.4), (134.1, -1.0), (135.0, -3.4), (137.8, -1.5),
              (140.8, -2.6), (144.5, -3.8), (146.0, -5.0), (147.5, -6.1), (147.9, -8.0),
              (150.1, -10.3), (148.3, -10.2), (146.1, -8.1), (143.6, -9.0), (141.0, -9.1),
              (138.9, -8.3), (137.9, -5.2), (135.0, -4.5), (133.0, -4.1), (132.0, -2.9)]

nz_north = [(172.7, -34.4), (174.3, -35.3), (175.9, -37.4), (178.5, -37.7), (177.9, -39.2),
            (176.8, -40.0), (175.2, -41.6), (174.6, -41.3), (175.1, -40.0), (173.8, -39.2),
            (174.6, -37.6), (174.3, -36.6), (173.1, -35.2)]
nz_south = [(172.7, -40.5), (174.3, -41.0), (174.0, -42.0), (172.8, -43.6), (171.2, -44.5),
            (170.6, -45.9), (169.3, -46.6), (166.5, -46.0), (166.6, -45.2), (168.2, -44.0),
            (170.6, -42.9), (171.5, -41.7), (172.1, -40.7)]
antarctica = [(80, -67.0), (90, -66.5), (100, -66.0), (110, -66.3), (120, -66.8), (130, -66.2),
              (140, -66.7), (150, -68.5), (160, -69.8), (166, -71.5), (170, -72.5), (167, -76.0),
              (164, -78.0), (170, -78.4), (180, -78.3), (190, -78.5), (200, -78.0), (210, -76.5),
              (220, -74.5), (230, -74.0), (230, -85.0), (150, -89.9), (80, -85.0)]

coasts = []
for poly in (australia, tasmania, new_guinea, nz_north, nz_south, antarctica):
    coasts.append([[round(c, 4) for c in project(lon, lat)[:2]] for lon, lat in poly])

with open("primer-logo.json", "w") as f:
    json.dump({"grid": grid, "coasts": coasts}, f)
print(len(grid), "visible grid edges")
