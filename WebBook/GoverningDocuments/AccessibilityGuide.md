# Accessibility Guide: Inclusive Content Design

This guide ensures the Computational Geodynamics Primer is accessible to all readers, including those with visual, auditory, cognitive, or motor impairments.

## Core Principles

1. **Universal Design**: Create content that works for everyone from the start
2. **Multiple Modalities**: Provide information through multiple channels
3. **Semantic Structure**: Use proper HTML structure for assistive technologies
4. **Readable Content**: Write clearly and organize logically
5. **Flexible Presentation**: Allow users to customize their experience

## Images and Figures

### Alt Text Requirements

Every image MUST include descriptive alt text that:
- Describes the content and function of the image
- Conveys the same information as the visual
- Is concise but comprehensive (aim for 1-2 sentences)
- Omits phrases like "image of" or "picture of"

### Writing Effective Alt Text

**For Diagrams:**
```markdown
❌ Bad: ![Diagram](convection.png)
❌ Bad: ![Image of convection](convection.png)
✅ Good: ![Thermal convection cell showing hot material rising at center and cool material descending at boundaries](convection.png)
```

**For Graphs:**
```markdown
✅ Good: ![Temperature profile showing exponential decay from 1300°C at the base to 0°C at the surface over 100 km depth](temperature-profile.png)
```

**For Photos:**
```markdown
✅ Good: ![Satellite image of Hawaiian island chain showing progression of volcanic islands from southeast to northwest](hawaii-satellite.png)
```

### Complex Figures

For figures with multiple components or detailed information:

1. **Provide detailed description in caption:**
```markdown
![Overview of subduction zone geometry](subduction-diagram.png){#fig-subduction}

**Figure Description:** Cross-section showing oceanic plate subducting beneath continental plate. Key features include: (1) oceanic trench at convergence, (2) subducting slab descending at ~45° angle, (3) volcanic arc on overriding plate, (4) back-arc basin, and (5) zone of intermediate-depth earthquakes along slab.
```

2. **Use long descriptions for very complex figures:**
```markdown
![Mantle convection simulation results](complex-simulation.png){#fig-simulation aria-describedby="sim-description"}

<div id="sim-description">
<details>
<summary>Detailed Figure Description</summary>
This figure shows four panels of a mantle convection simulation...
[Comprehensive description]
</details>
</div>
```

### Decorative Images

For purely decorative images with no informational content:
```markdown
![](decorative-banner.png){role="presentation"}
```

## Mathematical Content

### MathJax for Accessibility

Quarto uses MathJax, which provides good accessibility support:
- Screen readers can read mathematical expressions
- Users can zoom formulas without pixelation
- Alternative representations available

### Best Practices for Math

**1. Provide context in surrounding text:**
```markdown
❌ Bad:
The equation is:
$$
\frac{\partial T}{\partial t} = \kappa \nabla^2 T
$$

✅ Good:
The heat equation describes how temperature $T$ changes with time $t$:
$$
\frac{\partial T}{\partial t} = \kappa \nabla^2 T
$$ {#eq-heat}
where $\kappa$ is the thermal diffusivity and $\nabla^2$ is the Laplacian operator.
```

**2. Define all symbols:**
- Never introduce symbols without definition
- Maintain consistent notation throughout
- Use the common notation reference table

**3. Provide alternative descriptions for complex equations:**
```markdown
The momentum equation for Stokes flow is:
$$
-\nabla p + \nabla \cdot (\eta \nabla \mathbf{u}) + \rho \mathbf{g} = 0
$$ {#eq-stokes}

In words: the pressure gradient balances the viscous stress divergence and body forces.
```

### Equation Images

❌ **Never use images of equations** - they cannot be read by screen readers or searched

✅ **Always use MathJax/LaTeX** - fully accessible and searchable

## Document Structure

### Semantic Headings

Use proper heading hierarchy for navigation:

```markdown
✅ Correct:
# Chapter Title (H1)
## Major Section (H2)
### Subsection (H3)
#### Details (H4)

❌ Wrong:
# Chapter Title (H1)
#### Subsection (H4) - skips levels
```

**Why it matters:** Screen readers use headings for navigation. Proper hierarchy allows users to understand structure and jump between sections.

### Lists

Use appropriate list types:
- **Unordered lists** (`-`) for items without sequence
- **Ordered lists** (`1.`) for sequential steps or rankings
- **Definition lists** for term-definition pairs

### Tables

**1. Always include headers:**
```markdown
| Parameter | Symbol | Value |
|-----------|--------|-------|
| Viscosity | η      | 10²¹  |
```

**2. Add captions:**
```markdown
: Physical parameters for Earth's mantle {#tbl-mantle-params}
```

**3. Keep tables simple:**
- Avoid merged cells when possible
- Use multiple simple tables instead of one complex table
- Describe table content in text

**4. For complex tables, add summary:**
```markdown
<div role="region" aria-label="Mantle parameters summary" tabindex="0">

| Parameter | Value |
|-----------|-------|
[table content]

</div>
```

## Color and Contrast

### Color Usage

**Never rely on color alone** to convey information:

```markdown
❌ Bad: "The red line shows temperature, the blue line shows pressure"
✅ Good: "Temperature (solid line) and pressure (dashed line)"
```

### Color Palettes

Use colorblind-friendly palettes in figures:
- **Recommended:** Viridis, plasma, cividis
- **Avoid:** Rainbow/jet colormaps
- **Test:** Use colorblindness simulators

### Contrast Requirements

For text and important elements:
- **Normal text:** 4.5:1 contrast ratio minimum
- **Large text (18pt+):** 3:1 contrast ratio minimum
- **Graphics:** 3:1 contrast ratio minimum

**Current theme meets WCAG AA standards** for contrast.

## Links and Navigation

### Link Text

**Make links descriptive:**

```markdown
❌ Bad: Click [here](url) for more information
❌ Bad: Read more at [this link](url)
✅ Good: See the [Quarto accessibility documentation](url)
✅ Good: Consult [Turcotte & Schubert (2014)](url) for details
```

### Skip Links

Quarto automatically provides skip navigation links. Verify they work:
- Tab to first element (should highlight skip link)
- Press Enter (should skip to main content)

### Navigation Structure

For multi-level navigation:
```yaml
# In _quarto.yml
sidebar:
  style: "docked"
  collapse-level: 2  # Show 2 levels by default
```

Users can navigate by:
- Keyboard (Tab, Arrow keys, Enter)
- Screen reader landmarks
- Table of contents

## Interactive Content

### Jupyter Notebooks

**Accessibility considerations:**

1. **Add descriptive text before code:**
```python
# Calculate temperature profile
# This function implements equation @eq-heat
def temperature_profile(z, kappa, time):
    ...
```

2. **Describe visualizations:**
```python
# Generate plot
plt.plot(z, T)
plt.xlabel("Depth (km)")
plt.ylabel("Temperature (°C)")
plt.title("Lithospheric temperature profile")
plt.show()
```

In surrounding markdown:
"The plot shows temperature decreasing exponentially with depth..."

3. **Provide text summaries of results:**
```python
print(f"Surface heat flow: {q_surface:.2f} mW/m²")
print(f"Lithospheric thickness: {z_lith:.1f} km")
```

### Interactive Elements

For any interactive widgets:
- Provide keyboard alternatives
- Include text descriptions of functionality
- Ensure controls are labeled
- Don't require precise timing or motor control

## Code Accessibility

### Code Blocks

**1. Syntax highlighting:** Automatically provided by Quarto
**2. Line length:** Keep lines under 80 characters when possible
**3. Comments:** Add explanatory comments liberally

```python
# Calculate Rayleigh number
# Ra = (α g ΔT h³) / (κ ν)
alpha = 3e-5  # Thermal expansivity (1/K)
g = 10        # Gravity (m/s²)
delta_T = 1000  # Temperature difference (K)
h = 1e6       # Layer thickness (m)
kappa = 1e-6  # Thermal diffusivity (m²/s)
nu = 1e-4     # Kinematic viscosity (m²/s)

Ra = (alpha * g * delta_T * h**3) / (kappa * nu)
print(f"Rayleigh number: {Ra:.2e}")
```

### Readable Code Style

- Use descriptive variable names
- Avoid single-letter variables (except standard math notation)
- Add units in comments
- Break complex expressions into steps

## Cognitive Accessibility

### Clear Writing

1. **Use simple, direct language:**
   - Avoid unnecessarily complex vocabulary
   - Define technical terms on first use
   - Use active voice

2. **Structure content logically:**
   - Start with overview/introduction
   - Build from simple to complex
   - Summarize key points

3. **Break up long content:**
   - Use headings frequently
   - Limit paragraphs to 3-5 sentences
   - Use lists and tables to organize information

4. **Provide context and signposting:**
```markdown
In this module, we will:
1. Derive the heat equation
2. Solve for a simple boundary condition
3. Apply the solution to lithospheric cooling
```

### Callouts and Emphasis

Use callout blocks to highlight important information:

```markdown
:::{.callout-important}
The Boussinesq approximation assumes density variations are small except in the gravity term.
:::
```

**Don't overuse emphasis:**
- Too much **bold** or *italic* text reduces effectiveness
- Use strategically for key terms only

## Media Alternatives

### Figures and Diagrams

For every visual:
1. **Alt text** (required): Brief description
2. **Caption** (strongly recommended): Additional context
3. **Text description** (for complex figures): Full explanation in prose

### Videos (Future)

When adding video content:
- **Captions** for all spoken content (required)
- **Transcripts** as downloadable text (required)
- **Audio descriptions** for visual-only information (recommended)
- **Keyboard controls** (ensure video player is accessible)

### Animations

For animated figures:
- Provide static alternatives
- Allow user to control playback (pause, step through)
- Describe motion in text

## Testing and Validation

### Automated Testing

Use accessibility checkers:
```bash
# Check with axe-core or similar tool
npm install -g @axe-core/cli
axe [url] --tags wcag2a,wcag2aa
```

### Manual Testing

**1. Keyboard navigation:**
- Tab through entire page
- Verify all interactive elements are reachable
- Check focus indicators are visible

**2. Screen reader testing:**
- Test with NVDA (Windows), JAWS (Windows), or VoiceOver (Mac)
- Verify all content is read correctly
- Check reading order is logical

**3. Zoom testing:**
- Zoom to 200%
- Verify no content is cut off
- Check text reflows properly

**4. Color testing:**
- Use colorblindness simulator
- Check contrast ratios
- Verify information not conveyed by color alone

### User Testing

- Include users with disabilities in testing
- Gather feedback on accessibility
- Iterate based on real experiences

## WCAG Compliance Targets

Target **WCAG 2.1 Level AA** compliance:

### Level A (Minimum)
- [ ] All images have alt text
- [ ] Proper heading structure
- [ ] Keyboard accessible
- [ ] No color-only information
- [ ] Form labels provided

### Level AA (Target)
- [ ] 4.5:1 contrast for text
- [ ] 3:1 contrast for graphics
- [ ] Page titled descriptively
- [ ] Focus order logical
- [ ] Link purpose clear from text

### Level AAA (Aspirational)
- [ ] 7:1 contrast for text
- [ ] Supplemental alternative media
- [ ] Sign language for videos

## Accessibility Checklist

Before publishing content, verify:

### Images and Media
- [ ] All images have descriptive alt text
- [ ] Complex figures have extended descriptions
- [ ] No equations as images
- [ ] Color not sole means of conveying information
- [ ] Contrast ratios meet WCAG AA standards

### Structure
- [ ] Proper heading hierarchy (no skipped levels)
- [ ] Lists use appropriate markup
- [ ] Tables have headers and captions
- [ ] Landmarks used correctly (nav, main, etc.)

### Content
- [ ] Links are descriptive
- [ ] Language is clear and concise
- [ ] Technical terms defined
- [ ] Mathematical symbols explained
- [ ] Abbreviations expanded on first use

### Interactive Elements
- [ ] All functionality keyboard accessible
- [ ] Focus indicators visible
- [ ] Interactive elements labeled
- [ ] Notebooks include text descriptions
- [ ] Plots and figures described in text

### Technical
- [ ] Page has descriptive title
- [ ] Language attribute set
- [ ] Skip links functional
- [ ] No flashing content >3 times/second
- [ ] Zoom to 200% works correctly

## Resources

### Tools
- **Contrast checker:** [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
- **Screen readers:** NVDA (free), VoiceOver (Mac built-in)
- **Colorblind simulator:** [Coblis](https://www.color-blindness.com/coblis-color-blindness-simulator/)
- **Accessibility checker:** [axe DevTools](https://www.deque.com/axe/devtools/)

### Guidelines
- **WCAG 2.1:** [W3C Web Content Accessibility Guidelines](https://www.w3.org/WAI/WCAG21/quickref/)
- **Web AIM:** [WebAIM Articles](https://webaim.org/articles/)
- **Quarto docs:** [Quarto Accessibility](https://quarto.org/docs/authoring/accessibility.html)

### Training
- **W3C WAI tutorials:** [Web Accessibility Tutorials](https://www.w3.org/WAI/tutorials/)
- **A11y Project:** [The A11Y Project Checklist](https://www.a11yproject.com/checklist/)

---

**Accessibility is an ongoing commitment.** As we add new content and features, continuously evaluate and improve accessibility. When in doubt, prioritize the user experience of readers with disabilities.