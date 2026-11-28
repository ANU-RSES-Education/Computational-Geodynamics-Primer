"""Build the book without worked solutions (e.g. for use during an exam).

    pixi run build-exam          # HTML in WebBook/_build/exam/_build/html

Copies WebBook/ to _build/exam/, then in the copy
  * removes the solutions chapter from the table of contents, and
  * removes every note with `:class: solutions-link` (the pointer from each
    chapter's exercises to its solutions),
and builds it with MyST. The exercises themselves, and their {sup}`★` markers,
stay. Nothing in WebBook/ itself is changed.
"""
import pathlib
import re
import shutil
import subprocess

BOOK = pathlib.Path(__file__).resolve().parent.parent
DEST = BOOK / "_build" / "exam"


def strip_solution_links(text):
    """Remove :::{note} blocks whose options include `:class: solutions-link`."""
    lines = text.split("\n")
    out, i = [], 0
    while i < len(lines):
        if lines[i].startswith(":::{note}"):
            j = next(k for k in range(i + 1, len(lines)) if lines[k].strip() == ":::")
            if any(l.strip() == ":class: solutions-link" for l in lines[i + 1:j]):
                i = j + 1
                continue
        out.append(lines[i])
        i += 1
    return "\n".join(out)


if DEST.exists():
    shutil.rmtree(DEST)
shutil.copytree(BOOK, DEST, ignore=shutil.ignore_patterns("_build", ".DS_Store"))

myst = DEST / "myst.yml"
cfg = myst.read_text()
cfg, n = re.subn(r"\n\s*- file: Solutions/solutions\.md\s*(?=\n)", "", cfg)
assert n == 1, "solutions chapter not found in the table of contents"
cfg = cfg.replace("id: computational-geodynamics-primer", "id: computational-geodynamics-primer-exam")
myst.write_text(cfg)
shutil.rmtree(DEST / "Solutions")

removed = 0
for md in DEST.rglob("*.md"):
    text = md.read_text()
    new = strip_solution_links(text)
    if new != text:
        removed += text.count("solutions-link")
        md.write_text(new)
print(f"removed the solutions chapter and {removed} solution links")

subprocess.run(["myst", "build", "--html"], cwd=DEST, check=True)
print(f"exam build: {DEST / '_build' / 'html'}")
