# EDS Conversion Plan Template

## Project Metadata

- **Source Domain**: https://example.com
- **Downloaded**: YYYY-MM-DD
- **Project Name**: [Website Name]
- **Creator**: [Your Name]
- **Last Updated**: YYYY-MM-DD
- **Status**: Planning / In Progress / Complete

## Executive Summary

[1-2 sentences describing the website, its purpose, and the conversion scope]

## Page Inventory

### Page 1: [Page Name]
- **Source URL**: https://example.com/
- **Downloaded Location**: downloads/[folder]/index.html
- **Page Purpose**: [Description]
- **Primary Sections**: 
  - Header/Navigation
  - Hero banner
  - Feature cards
  - Testimonials
  - Footer
- **Key Content**: [Brief description]
- **Complexity**: ⭐⭐ (Medium)

### Page 2: [Page Name]
- **Source URL**: https://example.com/about
- **Downloaded Location**: downloads/[folder]/about/index.html
- **Page Purpose**: [Description]
- **Primary Sections**: [List sections]
- **Key Content**: [Brief description]
- **Complexity**: ⭐ (Simple)

## Block Architecture

### Blocks to Reuse from Boilerplate

- [x] `header` - Navigation and branding (with custom CSS)
- [x] `hero` - Large banner with hero image and CTA
- [x] `cards` - Feature/product card grid
- [x] `columns` - Multi-column layouts
- [x] `text` - Rich text content
- [x] `footer` - Footer section

### Custom Blocks to Create

#### Block 1: Testimonials ⭐⭐
- **Purpose**: Display customer testimonials in a grid or carousel
- **Usage Pages**: Homepage, case studies
- **Content Structure**:
  - Quote text
  - Author name
  - Author title/company
  - (Optional) Star rating
  - (Optional) Avatar image
- **JavaScript Features**:
  - Optional carousel rotation
  - Keyboard navigation
- **Styling**:
  - Card layout (responsive grid)
  - Quote styling
  - Author styling
- **Accessibility**: 
  - Semantic structure
  - ARIA labels if carousel
  - Keyboard supported

#### Block 2: [Block Name] ⭐⭐⭐
- **Purpose**: [Description]
- **Usage Pages**: [Which pages]
- **Content Structure**: [Describe content format]
- **JavaScript Features**: [Any interactivity]
- **Styling**: [Key style elements]
- **Accessibility**: [Special accessibility needs]

## Styling Strategy

### Color Palette
- **Primary Brand Color**: #0051BA (Blue)
- **Secondary Color**: #00AF41 (Green)
- **Accent Color**: #FF6B35 (Orange)
- **Neutral Dark**: #333333
- **Neutral Light**: #F5F5F5
- **Near White**: #FAFAFA

### Typography
- **Display/H1**: Montserrat, 700 (bold), 48px, line-height 1.2
- **Heading/H2**: Montserrat, 700 (bold), 36px, line-height 1.2
- **Subheading/H3**: Montserrat, 600 (semi-bold), 28px, line-height 1.3
- **Body Text**: Open Sans, 400 (regular), 16px, line-height 1.6
- **Small Text**: Open Sans, 400 (regular), 14px, line-height 1.5
- **Mono/Code**: Courier New, 400 (regular), 14px

### Responsive Breakpoints
- **Mobile**: < 768px (single column, full width)
- **Tablet**: 768px - 1024px (2-column, adjusted spacing)
- **Desktop**: > 1024px (3+ columns, optimized spacing)

### Design Elements
- **Border Radius**: 8px on cards, 4px on smaller elements
- **Box Shadows**: Subtle (0 2px 8px rgba(0,0,0,0.1)) for depth
- **Transitions**: 300ms ease-in-out for all interactive elements
- **Spacing System**: 8px base unit (8, 16, 24, 32, 48, 64px)

## JavaScript Requirements

### Interactive Features
1. **Mobile Navigation**: Hamburger menu toggles navigation on mobile
2. **Hover Effects**: Card elevation on hover
3. **Form Validation**: Basic client-side form validation
4. **Lazy Loading**: Images load on scroll visibility
5. **Smooth Scrolling**: Anchor links smooth-scroll to sections

### External Libraries
- **None** (keep dependencies minimal per EDS best practices)
- Optional: Intersection Observer API (built-in browser support)

### Performance Considerations
- No blocking scripts (defer or async)
- Minimal JavaScript (progressive enhancement)
- Event delegation for lists (not per-item listeners)

## Accessibility Requirements

All pages must meet **WCAG 2.1 Level AA** compliance:

- [ ] Color contrast 4.5:1 for text, 3:1 for UI components
- [ ] Keyboard navigation fully functional (Tab, Arrow keys, Enter)
- [ ] Focus indicators clearly visible
- [ ] All images have descriptive alt text
- [ ] Form labels associated with inputs
- [ ] ARIA landmarks (header, nav, main, footer)
- [ ] Semantic HTML structure (<h1>, <nav>, <main>, etc.)
- [ ] No auto-playing audio/video
- [ ] Captions on video content

## Content Specifications

### Image Guidelines
- **Format**: WebP with JPEG fallback for photography
- **PNG** for graphics with transparency
- **SVG** for logos and icons
- **Optimize**: Compress and scale appropriately
- **Alt Text**: Always descriptive and meaningful
- **Aspect Ratios**: Maintain original unless specified

### Copy Guidelines
- **Tone**: [Professional, Friendly, Technical, etc.]
- **Length**: [Brief, Standard, Detailed]
- **Keywords**: [Main search terms for SEO]
- **Brand Voice**: [Description]

## Build Order / Dependencies

```
Phase 1: Foundation (if new custom utilities needed)
  ├─ Color variables (update styles/styles.css)
  └─ Typography utilities

Phase 2: Layout Blocks
  ├─ Modified `header` (with custom navigation)
  ├─ Modified `hero` (with custom styling)
  ├─ `cards` block (as-is or with tweaks)
  └─ `columns` block (as-is or with tweaks)

Phase 3: Content Blocks
  ├─ `text` block
  └─ `fragment` block (if needed)

Phase 4: Custom Complex Blocks
  ├─ `testimonials` block
  └─ [Other custom blocks]

Phase 5: Footer
  └─ Modified `footer` (with custom styling)
```

**Estimated buildtime per block**: 2-4 hours depending on complexity.

## Content Migration Strategy

### Source → EDS Mapping

| Source Page | EDS Page | Special Handling |
|---|---|---|
| homepage | / | Main landing page |
| /about | /about | About/company info |
| /services | /services | Services listing |
| /blog | /news | Blog posts (if applicable) |
| /contact | /contact | Contact form (manual setup in da.live) |

### Content Extraction Notes
- [Note any special formatting or content types]
- [Note any dynamic content requiring manual setup]
- [Note any legacy content to exclude]

## Challenges & Mitigation

| Potential Challenge | Severity | Solution |
|---|---|---|
| [Challenge] | High/Medium/Low | [How to handle] |
| Third-party embeds | Medium | Hide or create placeholder |
| Video content | Low | Link to external player |
| Form submissions | High | Set up mailing service in da.live |
| Dynamic pricing | High | Create content blocks with manual updates |

## Risk Assessment

- **High Risk Items**: (Will need special attention)
- **Medium Risk Items**: (May need iteration)
- **Low Risk Items**: (Straightforward conversion)

## Estimated Effort

| Phase | Est. Hours | Notes |
|---|---|---|
| Analysis & Planning | 4-6 | Completing now |
| Component Building | 15-20 | Depends on custom block complexity |
| Content Generation | 3-5 | Copy/paste content from source |
| QA & Refinement | 5-8 | Testing pixel-perfect match |
| **Total** | **27-39 hours** | **1-2 weeks** |

## Sign-off Checklist

- [ ] All pages documented
- [ ] Block inventory complete
- [ ] Styling strategy defined
- [ ] JavaScript requirements clear
- [ ] Content migration planning done
- [ ] No blocking dependencies identified
- [ ] Effort estimate realistic
- [ ] Ready to proceed with Step 3 (Component Building)

## Next Steps

1. **Review this plan** with team
2. **Get approval** to proceed
3. **Start Step 3**: Build components using this plan as reference
4. **Use CONVERSION_PLAN.md** as authority for all naming, styling, and functionality decisions

---

*This Conversion Plan is the authoritative guide for this EDS conversion project.*
*Keep updated as you progress through building phases.*
