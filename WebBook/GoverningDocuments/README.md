# Governing Documents

This directory contains planning and guidance documents for the Computational Geodynamics Primer project. These documents are **not published** in the book itself but guide its development.

## Contents

### [Plan-2025-2026.md](Plan-2025-2026.md)
**Development roadmap and strategy**

Outlines the core vision and implementation strategy for the book:
- Vertical strand demonstration approach
- Modular content structure (2-3 page units)
- Three teaching themes: Heat Conduction, Mantle Convection, Stokes Flow
- Success criteria and expansion strategy
- No rigid timelines - focuses on approach and priorities

**Use this when:**
- Planning what to work on next
- Understanding the overall book philosophy
- Deciding how to structure new content
- Evaluating progress

### [WritingStyleGuide.md](WritingStyleGuide.md)
**Content organization and pedagogical approach**

Covers how to write and organize content:
- Module structure (2-3 pages with theory, code, applications)
- Content length guidelines and when to split
- How to use notebooks effectively
- Exercise types and density
- Mathematical exposition style
- Tone and voice for different audiences
- Progressive complexity scaffolding

**Use this when:**
- Writing new content
- Structuring a module or chapter
- Deciding how to present material
- Creating exercises
- Choosing between text and code

### [MarkupStyleGuide.md](MarkupStyleGuide.md)
**Technical formatting with Quarto markdown**

Technical details for formatting `.qmd` files:
- File naming and organization
- Mathematical notation (MathJax, macros)
- Figure and image syntax
- Code blocks (Python, pyodide, notebooks)
- Citations and bibliography
- Callout blocks and cross-references
- Tables and lists

**Use this when:**
- Formatting existing content
- Adding equations, figures, or code
- Creating cross-references
- Setting up citations
- Troubleshooting markup issues

### [AccessibilityGuide.md](AccessibilityGuide.md)
**Making content accessible to all readers**

Ensuring content is inclusive:
- Alt text for images (requirements and examples)
- Mathematical accessibility with MathJax
- Document structure for screen readers
- Color and contrast guidelines
- Keyboard navigation
- Cognitive accessibility (clear writing, structure)
- WCAG compliance checklist

**Use this when:**
- Adding images or figures
- Creating complex visualizations
- Reviewing content for accessibility
- Testing with assistive technologies
- Ensuring inclusive design

### [NavigationStructure.md](NavigationStructure.md)
**Organizing book navigation and sidebar**

Implementing three-level navigation hierarchy:
- Parts → Sections → Modules structure
- Configuration in `_quarto.yml`
- Directory organization to match navigation
- Collapse behavior and sidebar settings
- Examples for different organizational approaches
- Migration strategy for restructuring content

**Use this when:**
- Restructuring the book organization
- Adding new sections or themes
- Configuring `_quarto.yml`
- Planning directory structure
- Testing navigation behavior

## Document Relationships

```
Plan-2025-2026.md
    ↓ (defines strategy)
    ├→ WritingStyleGuide.md (how to write modules)
    │   ├→ MarkupStyleGuide.md (how to format)
    │   └→ AccessibilityGuide.md (how to make accessible)
    └→ NavigationStructure.md (how to organize)
```

## Quick Reference

| Task | Primary Document | Supporting Docs |
|------|------------------|-----------------|
| Planning next phase | Plan-2025-2026 | - |
| Creating new module | WritingStyleGuide | MarkupStyleGuide, AccessibilityGuide |
| Formatting equations | MarkupStyleGuide | WritingStyleGuide (context) |
| Adding images | AccessibilityGuide | MarkupStyleGuide (syntax) |
| Restructuring parts | NavigationStructure | Plan-2025-2026 (strategy) |
| Writing exercises | WritingStyleGuide | MarkupStyleGuide (callouts) |
| Setting up notebooks | WritingStyleGuide | MarkupStyleGuide (code blocks) |
| Reviewing for accessibility | AccessibilityGuide | All (comprehensive check) |

## Workflow: Creating New Content

1. **Plan** (Plan-2025-2026.md)
   - Where does this fit in the vertical strand?
   - Is this a new theme or expanding existing?

2. **Structure** (WritingStyleGuide.md)
   - What module structure? (Fundamentals, Applications, etc.)
   - What length? (2-3 pages)
   - What exercises?

3. **Write** (WritingStyleGuide.md + MarkupStyleGuide.md)
   - Follow content guidelines
   - Use proper markup syntax
   - Include code/notebooks as appropriate

4. **Make Accessible** (AccessibilityGuide.md)
   - Add alt text to all images
   - Check contrast and structure
   - Verify keyboard navigation

5. **Integrate** (NavigationStructure.md)
   - Place in appropriate section
   - Update `_quarto.yml`
   - Test navigation

## Updating These Documents

These are **living documents** and should be updated as we:
- Learn what works pedagogically
- Discover better technical approaches
- Receive user feedback
- Expand to new content areas
- Identify new accessibility needs

When you update a document, note the change in the document itself (add a "Last Updated" or "Changelog" section if needed).

## Version Control

These governance documents are tracked in git along with the book content. Significant changes to strategy or guidelines should be:
- Committed with clear messages
- Discussed with project team
- Documented in commit messages

## Questions?

If you need clarification on any of these documents or encounter situations not covered:
1. Check the related documents (see relationships above)
2. Open an issue on GitHub
3. Discuss with project maintainers
4. Update the relevant document with the answer

---

**Last Updated:** 2025-11-10