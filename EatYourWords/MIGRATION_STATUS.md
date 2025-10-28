# Content Migration Status

This document tracks which content from `EatYourWords/` has been migrated to the main `WebBook/` structure.

**Notation**:
- ~~Strikethrough~~ = Fully migrated to WebBook
- `[PARTIAL]` = Partially migrated, some content remains to integrate
- Unmarked = Not yet migrated

---

## EatYourWords/Geophysics/ (Single-author Jupyter Book material)

Ready to migrate with minimal restyling.

### Part 0: Introduction
- ~~**Introduction.md**~~ → Migrated to `WebBook/intro.qmd` (Overview, What is a Model, Mathematical Background, Programming sections)

### Part 1: Fluid Dynamics
- **ContinuumMechanics.md** `[PARTIAL]` → `WebBook/DraftMaterial/ContinuumMechanics.qmd`
- **NavierStokes.md** `[PARTIAL]` → `WebBook/DraftMaterial/NavierStokes.qmd`
- **MantleDynamics.md** `[PARTIAL]` → `WebBook/DraftMaterial/MantleDynamics.qmd`
- **StokesFlowApplications.md** `[PARTIAL]` → `WebBook/DraftMaterial/StokesFlowApplications.qmd`
- **ThermalConvection.md** `[PARTIAL]` → `WebBook/DraftMaterial/ThermalConvection.qmd`
- **LithosphericDynamics.md** `[PARTIAL]` → `WebBook/DraftMaterial/LithosphericDynamics.qmd`

### Part 2: Python Tutorials

**Introduction to Python**:
- 0-StartHere.md
- Introduction2Python/1-IntroductionToJupyterNotebooks.md
- Introduction2Python/2-IntroductionToIpython.md
- Introduction2Python/3-PythonDataTypes.md
- Introduction2Python/4-PythonClasses.md

**Version Control with Git**:
- Introduction2VersionControl/1-GettingStartedWithGit.md
- Introduction2VersionControl/2-NextStepsWithGit.md
- Introduction2VersionControl/3-YourOwnRepositories.md

**NumPy & SciPy Tutorials**:
- NumpyAndScipy/0-NumpyAndScipy.md
- NumpyAndScipy/1-IntroductionToNumpy.md
- NumpyAndScipy/2-Application-TheGameOfLife.md
- NumpyAndScipy/3-Discussion-TheGameOfLife.md
- NumpyAndScipy/4-IntroductionToScipy.md
- NumpyAndScipy/5-ScipyInterpolate.md
- NumpyAndScipy/6-ScipySpatialAndMeshing.md
- NumpyAndScipy/7-ScipyOptimize.md
- NumpyAndScipy/8-Numpy+ScipyMiscellany.md

**Matplotlib Plotting**:
- Plotting/1-IntroductionToMatplotlib.md

**Cartopy Mapping** (11 comprehensive chapters):
- Mapping/0-Maps_with_Cartopy.md
- Mapping/0-Preliminaries.md
- Mapping/1-IntroducingCartopy.md
- Mapping/2-ImagesAndGeoTIFFs.md
- Mapping/3-WorkingWithRealData.md
- Mapping/4-ContouringGlobalData.md
- Mapping/5-WorkingWithPointData.md
- Mapping/6-WorkingWithShuttleRadarTopography.md
- Mapping/7-WorkingWithOn-DemandMappingServices.md
- Mapping/8-GlobalPlateMotionsEtc.md
- Mapping/9-HimalayaRegionMapsAndImages.md
- Mapping/9a-HimalayaRegionMapsAndImages-Pt2.md

**Spherical Meshing**:
- SphericalMeshing/0-Stripy.md

### Part 3: Numerical Methods
- **NumericalMethods1.md** `[PARTIAL]` → `WebBook/DraftMaterial/NumericalMethods1.qmd`
- **NumericalMethods2.md** `[PARTIAL]` → `WebBook/DraftMaterial/NumericalMethods2.qmd`
- **NumericalMethods3.md** `[PARTIAL]` → `WebBook/DraftMaterial/NumericalMethods3.qmd`
- **NumericalMethods4.md** `[PARTIAL]` → `WebBook/DraftMaterial/NumericalMethods4.qmd`
- **NumericalMethods5.md** `[PARTIAL]` → `WebBook/DraftMaterial/NumericalMethods5.qmd`

---

## EatYourWords/latex_originals/ICFM/ (Multi-author Incompressible Fluid Mechanics)

More complex material, requires significant rework due to multiple authors and LaTeX format.

### Chapter 1: Fluid Flow and Conservation of Mass
- **Section 1.1**: Description of fluid flow
- **Section 1.2**: Equations for streamlines
- **Section 1.3**: Distinctive properties of fluids
- **Section 1.4**: Incompressible flows
- **Section 1.5**: Conservation of mass: the continuity equation
- **Section 1.6**: Strain rate, Velocity gradients, and Vorticity
- Exercises + Solutions (not yet extracted)

### Chapter 2: Equation of Motion
- **Section 2.1**: Newton's Second Law
- **Section 2.2**: Rate-of-change moving with the fluid
- **Section 2.3**: Internal forces in a fluid
- **Section 2.4**: Fluid and solids: pressure
- **Section 2.5**: Equation of Motion for an inviscid fluid
- **Section 2.6**: Equations of motion in cylindrical polars
- **Section 2.7**: Dynamic or perturbation pressure
- **Section 2.8**: Incompressible viscous fluids
- **Section 2.9**: Boundary conditions for fluid flow
- Exercises + Solutions (not yet extracted)

### Chapter 3: Steady Inviscid Flows
- **Section 3.1**: Bernoulli's equation
- **Section 3.2**: Applications of Bernoulli's equation
- Exercises + Solutions (not yet extracted)

### Chapter 4: Vortex Motion
- **Section 4.1**: The vorticity field
- **Section 4.2**: Circulation
- **Section 4.3**: The Helmholtz equation for vorticity
- (Additional sections continue...)

---

## Repository Status

**EatYourWords/Geophysics/** is now a regular tracked directory (converted from nested git repository). All content, including the extensive diagram library, is now properly tracked and can be updated with migration progress.

## Integration Notes

### Priority Ordering
1. **High Priority**: Part 0 Introduction (✓ DONE), Part 1 Fluid Dynamics chapters (in DraftMaterial)
2. **Medium Priority**: Part 3 Numerical Methods chapters, ICFM introductory sections
3. **Lower Priority**: Python tutorials (can be developed incrementally), ICFM advanced sections

### Known Issues to Address
- ICFM uses LaTeX commands and multi-author formatting that needs modernization
- Some diagram references need paths updated
- Python code blocks need testing with Pyodide (browser-based execution)
- ICFM contains exercises/solutions that may need extraction

### Next Steps
1. [ ] Review and reorganize draft material into final Part structure
2. [ ] Migrate Python tutorial content to appropriate location
3. [ ] Extract and convert ICFM chapters as needed for specific parts
4. [ ] Update all image paths to point to `WebBook/Images/`
5. [ ] Test Python code blocks with Pyodide
