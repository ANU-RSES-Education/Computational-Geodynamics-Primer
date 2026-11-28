"""Move worked solutions out of the chapters into Solutions/solutions.md.

One-off restructuring script (kept for reference). For each chapter:
  * every `:::{tip} Solution to Exercise N: Title` block is removed from the
    chapter and becomes `### Exercise N: Title` in the solutions chapter;
  * the "Solutions to Selected Exercises" heading is removed;
  * the note announcing starred exercises becomes a note, with class
    `solutions-link`, pointing to that chapter's section of the solutions
    (the exam build removes these notes, see scripts/build_exam.py);
  * the Exercises heading gets a label so the solutions can link back.
Run from WebBook/:  python scripts/split_solutions.py
"""
import pathlib
import re

CHAPTERS = [  # book order
    ("Part2-FluidDynamics/navier-stokes.md", "navier-stokes"),
    ("Part2-FluidDynamics/inviscid-flows.md", "inviscid-flows"),
    ("Part2-FluidDynamics/nondimensional-equations.md", "nondimensional-equations"),
    ("Part3-Geodynamics/stress-and-faulting.md", "stress-and-faulting"),
    ("Part3-Geodynamics/rayleigh-benard-convection.md", "rayleigh-benard-convection"),
    ("Part5-Computational/Benchmarks/analytical-solutions.md", "analytical-solutions"),
]
OPEN = re.compile(r"^(:{3,})\{")
SOL = re.compile(r"^(:{3,})\{tip\}\s*Solution to Exercise\s+(\d+)\s*:?\s*(.*)$")
STAR_NOTE = re.compile(r"(marked with|marked with ⭐|Exercises marked with)", re.I)


def block_end(lines, i):
    """Index of the line closing the directive opened at lines[i] (fence-aware)."""
    fence = OPEN.match(lines[i]).group(1)
    depth = 0
    for j in range(i, len(lines)):
        l = lines[j].rstrip()
        m = OPEN.match(l)
        if m and len(m.group(1)) == len(fence):
            depth += 1
        elif l == fence:
            depth -= 1
            if depth == 0:
                return j
    raise ValueError(f"unclosed directive at line {i + 1}")


def title_of(lines):
    for l in lines:
        if l.startswith("# "):
            return re.sub(r"\s*\{#.*\}$", "", l[2:]).strip()
    return "Untitled"


out = ["(sec-solutions)=",
       "# Solutions to Selected Problems",
       "",
       "Worked solutions to the exercises marked {sup}`★` in each chapter, in the order",
       "the chapters appear in the book. Try the exercise before reading the solution.",
       ""]

for path, slug in CHAPTERS:
    p = pathlib.Path(path)
    lines = p.read_text().split("\n")
    chapter_title = title_of(lines)
    keep, sols, i = [], [], 0
    while i < len(lines):
        m = SOL.match(lines[i])
        if m:
            j = block_end(lines, i)
            body = [l for l in lines[i + 1:j] if not l.startswith(":class:")]
            while body and not body[0].strip():
                body.pop(0)
            while body and not body[-1].strip():
                body.pop()
            title = m.group(3).strip()
            if not title:
                h = next((l for l in lines if re.match(rf"^#+ Exercise {m.group(2)}\b", l)), "")
                title = re.sub(r"\s*\{sup\}`★`", "", h.split(":", 1)[1]).strip() if ":" in h else ""
            sols.append((int(m.group(2)), title, body))
            i = j + 1
            continue
        keep.append(lines[i])
        i += 1
    if not sols:
        continue
    text = "\n".join(keep)
    # drop the now-empty solutions heading (and any blank run after it)
    text = re.sub(r"\n## Solutions to Selected Exercises\s*\n(\s*\n)*", "\n", text)
    # label the exercises heading
    if f"(sec-{slug}-exercises)=" not in text:
        text = text.replace("\n## Exercises\n", f"\n(sec-{slug}-exercises)=\n## Exercises\n", 1)
    # replace the starred-exercise note, line by line: the line announcing the
    # stars, widened to its own enclosing {note} only if no other fence lies between
    pointer = [":::{note} Solutions", ":class: solutions-link",
               f"Exercises marked {{sup}}`★` have worked solutions in [](#sol-{slug}).", ":::"]
    tl = text.split("\n")
    k = next(i for i, l in enumerate(tl) if "marked with" in l)
    start = end = k
    if tl[k].startswith(":::{note}"):          # text on the opening line itself
        end = next(j for j in range(k + 1, len(tl)) if tl[j].strip() == ":::")
    elif k > 0 and tl[k - 1].startswith(":::{note}"):
        start = k - 1
        end = next(j for j in range(k + 1, len(tl)) if tl[j].strip() == ":::")
        assert all(not l.startswith(":::") for l in tl[start + 1:end]), path
    tl[start:end + 1] = pointer
    text = "\n".join(tl)
    p.write_text(re.sub(r"\n{3,}", "\n\n", text))

    out += [f"(sol-{slug})=", f"## {chapter_title}", "",
            f"Exercises: [](#sec-{slug}-exercises).", ""]
    for num, title, body in sorted(sols):
        out += [f"### Exercise {num}: {title}" if title else f"### Exercise {num}", "", *body, ""]
    print(f"{path}: {len(sols)} solutions moved")

sol = pathlib.Path("Solutions/solutions.md")
sol.parent.mkdir(exist_ok=True)
sol.write_text("\n".join(out).rstrip() + "\n")
print("wrote", sol)
