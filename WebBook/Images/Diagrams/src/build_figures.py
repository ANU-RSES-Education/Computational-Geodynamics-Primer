"""Rebuild every figure in Images/Diagrams from its source in src/.

    pixi run figures            # all figures
    pixi run figures NAME ...   # only these (folder names under src/)

Typst sources (src/NAME/NAME.typ) become NAME.svg and a 300 dpi NAME.png.
If src/NAME/NAME.py exists it is run first, in that folder, to write the
data the Typst source reads (computed curves, schedules).
"""
import pathlib
import subprocess
import sys

DIAGRAMS = pathlib.Path(__file__).resolve().parent.parent
SRC = DIAGRAMS / "src"


def build_typst(src: pathlib.Path) -> None:
    name = src.stem
    # A figure that plots computed values has src/NAME/NAME.py, which writes
    # its data (e.g. NAME.json) beside the .typ source before Typst runs.
    data_script = src.with_suffix(".py")
    if data_script.exists():
        subprocess.run([sys.executable, "-I", data_script.name], cwd=src.parent, check=True)
    for out, extra in ((f"{name}.svg", []), (f"{name}.png", ["--format", "png", "--ppi", "300"])):
        subprocess.run(
            ["typst", "compile", "--root", str(DIAGRAMS), *extra, str(src), str(DIAGRAMS / out)],
            check=True,
        )
    print(f"built {name}")


def main(names: list[str]) -> None:
    sources = sorted(SRC.glob("*/*.typ"))
    if names:
        sources = [s for s in sources if s.parent.name in names]
    for src in sources:
        build_typst(src)


if __name__ == "__main__":
    main(sys.argv[1:])
