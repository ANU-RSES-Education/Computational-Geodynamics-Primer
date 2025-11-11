# Writing Style Guide: Content Structure and Pedagogy

This guide focuses on **how to write and organize content** for the Computational Geodynamics Primer, not technical markup (see Markup Style Guide for that).

## Core Philosophy

The book uses a **modular, application-driven approach** where:
- Theory connects directly to Earth processes
- Computation is integral, not supplementary
- Content builds progressively from fundamentals to applications
- Readers can follow vertical themes or explore horizontally

## Content Organization

### Modular Structure

Each topic is broken into **2-3 page modules** that are:
- **Self-contained**: Can be understood independently
- **Connected**: Link to prerequisites and follow-up topics
- **Focused**: Cover one clear concept or application
- **Mixed-media**: Combine text, equations, code, and visualizations

### Module Components

A complete module typically includes:

1. **Introduction (1-2 paragraphs)**
   - What is this concept?
   - Why does it matter for geodynamics?
   - How does it connect to previous/upcoming material?

2. **Core Content (1-2 pages)**
   - Theoretical development
   - Key equations and derivations
   - Physical interpretation
   - Worked examples

3. **Computational Component**
   - Jupyter notebook with implementation
   - Parameter exploration
   - Visualization of results

4. **Earth Applications**
   - Real-world examples
   - Typical parameter values
   - Observable consequences

5. **Extensions (optional)**
   - Advanced topics
   - Current research questions
   - Further reading

## Content Length Guidelines

### Page Equivalents
- **Short module**: 2 pages (~800-1000 words)
- **Standard module**: 3 pages (~1200-1500 words)
- **Extended module**: 4-5 pages (for complex topics only)

### When to Split Content
Split into multiple modules when:
- A single concept requires >1500 words
- Multiple distinct applications exist
- Computational examples become complex
- Different skill levels are addressed

### Length by Component Type
- **Introduction**: 100-200 words
- **Derivation**: 300-600 words per major result
- **Worked example**: 200-400 words
- **Application**: 300-500 words
- **Summary**: 100-150 words

## Use of Code and Notebooks

### When to Use Notebooks

**DO use notebooks for:**
- Numerical implementations of equations
- Parameter studies and sensitivity analysis
- Data visualization and analysis
- Benchmark problems
- Real-world applications with data

**DON'T use notebooks for:**
- Simple mathematical definitions
- Conceptual explanations better shown in text
- Single-line calculations that can be inline
- Repetitive examples without variation

### Notebook Design Principles

1. **Start simple**: Begin with minimal working example
2. **Build complexity**: Add features incrementally
3. **Annotate thoroughly**: Explain every code block
4. **Visualize results**: Always show output graphically
5. **Invite exploration**: Suggest parameter variations
6. **Ensure reproducibility**: Include all dependencies

### Notebook Structure
```
1. Context and Objectives (markdown cell)
2. Import statements (code cell)
3. Define parameters (code cell)
4. Implement core functions (code cells with explanations)
5. Run and visualize (code cells)
6. Explore and discuss (mixed markdown/code)
7. Exercises (markdown cell)
```

### Code Style in Notebooks
- Use clear variable names (avoid single letters except for standard math notation)
- Comment non-obvious steps
- Keep functions short and focused
- Use descriptive function and variable names
- Include units in comments where relevant
- Prefer NumPy/SciPy idioms over loops where possible

## Use of Exercises

### Types of Exercises

1. **Check Understanding**: Simple questions testing concept comprehension
   - Placed within text as callout boxes
   - Answers can be conceptual
   - Example: "Why must the divergence of velocity be zero in an incompressible fluid?"

2. **Pencil-and-Paper**: Analytical problems requiring calculation
   - End of module or section
   - Build mathematical skills
   - Example: "Derive the steady-state solution for the heat equation with..."

3. **Computational**: Notebook-based programming exercises
   - Extend or modify provided code
   - Implement variations of algorithms
   - Example: "Modify the cooling model to include temperature-dependent conductivity"

4. **Application**: Real-world parameter estimation or interpretation
   - Use Earth data
   - Require physical reasoning
   - Example: "Given these heat flow measurements, estimate the lithospheric thickness..."

### Exercise Density

- **Minimum**: 2-3 exercises per module
- **Recommended**: 4-6 exercises per module (mix of types)
- **Distribution**: Spread throughout, not just at end

### Writing Effective Exercises

**Good Exercise:**
> "The Rayleigh number for Earth's mantle is ~10^7. Using the notebook above, explore how convection patterns change as Ra varies from 10^4 to 10^8. At what value does the transition from steady to time-dependent convection occur?"

**Poor Exercise:**
> "Calculate the Rayleigh number." (Too vague, no context)

**Guidelines:**
- Provide sufficient context and information
- State what to calculate, estimate, or demonstrate
- Indicate expected result type (number, plot, explanation)
- Link to specific notebooks or equations
- Suggest thought process or approach when appropriate

## Mathematical Exposition

### Derivation Style

**Progressive revelation**: Build equations step-by-step
```
Start with:     Physical principle
Show:           Mathematical statement
Develop:        Intermediate steps
Arrive at:      Final form
Interpret:      Physical meaning
```

### Balance Rigor and Intuition

- State assumptions clearly upfront
- Provide physical interpretation alongside math
- Use limiting cases to build intuition
- Connect to familiar concepts
- Acknowledge when full rigor is beyond scope

### Equation Presentation

- **Display equations** for important results: Use numbered equation blocks
- **Inline math** for variables and simple expressions: Within sentences
- **Avoid**: Long inline equations that break reading flow

## Referencing and Citations

### When to Cite

**Always cite:**
- Original derivations or formulations
- Numerical methods or algorithms
- Observational data or measurements
- Figures adapted from other sources
- Specific model results or parameter values
- Reviews that provide comprehensive treatment

**No need to cite:**
- Well-established textbook material (e.g., basic calculus)
- Common knowledge in the field
- Your own original derivations or explanations

### Citation Style

**In text:**
- Single author: "As shown by Smith (1990)..."
- Multiple authors: "Previous work (Jones et al., 1995; Lee & Chen, 2002) demonstrated..."
- Attribution: "The Boussinesq approximation (Boussinesq, 1903) assumes..."

**End of module:**
- Include brief "Further Reading" section with 3-5 key references
- Annotate why each reference is useful
- Mix foundational papers and recent reviews

### Building the Bibliography

- Prefer DOI links when available
- Include complete information in `references.bib`
- Use consistent citation keys: `authorYEARword` format
- Add keywords/tags for categorization

## Writing for Different Audiences

### Graduate Students (Primary Audience)
- Assume undergraduate physics/math background
- Define specialized terminology
- Provide motivation for each topic
- Include computational exercises at appropriate level

### Researchers (Secondary Audience)
- Provide citations to current literature
- Include advanced topics in callouts or appendices
- Reference state-of-the-art methods
- Suggest research directions

### Instructors (Supporting Audience)
- Modular structure allows topic selection
- Exercises at multiple levels
- Suggest timing (e.g., "suitable for 2-3 lectures")
- Provide context for curriculum planning

## Tone and Voice

### General Principles
- **Active voice**: "We derive..." not "It can be derived..."
- **Direct address**: "You will see..." or "Consider..."
- **Present tense** for established facts: "The mantle convects..."
- **Past tense** for studies: "Smith (1990) showed..."

### Avoid
- Excessive jargon without definition
- Apologetic language ("unfortunately", "merely")
- Overly casual language (maintain professionalism)
- Assuming reader's familiarity with specialized topics

### Encourage
- Intellectual curiosity: "What happens if...?"
- Connection to observations: "We see this in..."
- Physical intuition: "This makes sense because..."
- Computational thinking: "We can test this by..."

## Visual Elements

### Figures
- Every figure must have a caption explaining what is shown
- Reference figures in text: "As shown in Figure X..."
- Label axes with quantities and units
- Use colorblind-friendly palettes
- Size appropriately: Not too small to read, not overwhelming

### Diagrams
- Simplify to essential features
- Use consistent symbol conventions
- Annotate clearly
- Prefer vector graphics (SVG, PDF) over raster

### Tables
- Use for comparisons and parameter listings
- Keep concise (max ~10 rows before considering splitting)
- Include units in headers
- Right-align numerical data
- Add explanatory caption

## Progressive Complexity

### Scaffolding Knowledge

**Level 1: Introduce**
- Present simplified version
- Focus on physical intuition
- Use dimensional analysis

**Level 2: Develop**
- Add mathematical rigor
- Include derivations
- Discuss assumptions

**Level 3: Apply**
- Real-world parameters
- Complex geometries
- Coupled processes

**Level 4: Extend**
- Current research
- Open questions
- Advanced methods

### Signposting Difficulty

Use callouts to indicate advanced material:
```markdown
:::{.callout-note collapse="true"}
## Advanced Topic: Anelastic Formulation
[Optional advanced content here]
:::
```

## Quality Checklist

Before finalizing a module, verify:

- [ ] Clear learning objectives stated or implied
- [ ] Logical flow from introduction to application
- [ ] All notation defined before use
- [ ] Consistent with book-wide notation conventions
- [ ] Equations numbered and referenced
- [ ] Figures captioned and referenced
- [ ] Code tested and executable
- [ ] Exercises included and well-posed
- [ ] Citations complete and formatted correctly
- [ ] Connections to other modules noted
- [ ] Appropriate length (not too dense or too sparse)
- [ ] Accessible language (defined jargon, clear explanations)

## Revision Process

1. **Draft**: Get ideas down, focus on content
2. **Structure**: Organize into logical flow
3. **Refine**: Clarify language, add examples
4. **Connect**: Add cross-references, check notation consistency
5. **Polish**: Proofread, verify citations, test code
6. **Review**: Get feedback from colleagues or students
7. **Finalize**: Incorporate feedback, final check

## Example Module Outline

```
# Heat Conduction in the Lithosphere

## Introduction
[Physical context: cooling plates, heat flow observations]
[Connection: Links to plate tectonics, mantle convection]

## Mathematical Framework
[Heat equation, boundary conditions]
[Cooling half-space model derivation]

## Analytical Solution
[Step-by-step solution]
[Worked example with Earth parameters]

## Computational Implementation
[Link to Jupyter notebook: lithosphere_cooling.ipynb]
[Notebook explores: parameter sensitivity, comparison with observations]

## Earth Applications
[Seafloor depth-age relationship]
[Heat flow data interpretation]
[Continental geotherms]

## Exercises
1. Check understanding: Why does half-space work better than plate model at young ages?
2. Computational: Modify notebook to include temperature-dependent conductivity
3. Application: Given heat flow profile, estimate thermal age

## Further Reading
- Turcotte & Schubert (2014) - Comprehensive treatment
- Stein & Stein (1992) - Seafloor depth-age models
```

---

This guide is a living document. As we develop content and learn what works best, update these guidelines accordingly.