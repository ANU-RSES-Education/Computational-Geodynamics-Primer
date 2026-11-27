(sec-numerical-methods)=
# Numerical Methods


The equations of the earlier parts can be solved exactly only for simple
geometries and material properties. To study the Earth we need approximate
solutions, computed on a discretised domain, and we need to know how good those
approximations are. This part develops the methods we use, with the finite
element method as the main thread.

The chapters build on each other:

- [Time integration](time-integration.md) uses the decay equation to introduce
  discretisation, truncation error and stability, and writes the first code.
- [Survey of numerical methods](survey-of-methods.md) compares explicit and
  implicit schemes, shows why advection is difficult on a fixed grid, and
  places finite differences, finite elements, finite volumes, spectral and
  particle methods side by side.
- [Introduction to the finite element method](fem-introduction.md) starts from
  variational principles and arrives at a matrix problem.
- [Practical finite elements](fem-practice.md) derives weak forms for heat
  conduction and Stokes flow, then introduces shape functions, element
  matrices and numerical integration.
- [Methods for solving numerical problems](solvers.md) covers iterative solvers,
  multigrid and the mixed velocity–pressure formulation.

If you already have a short overview of finite elements and want the detail,
start with [](#sec-fem-introduction) and refer back to the survey for the
comparison with other methods.
