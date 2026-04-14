---
name: eds-conversion
description: "EDS Website Conversion skill bundle. Contains scripts, templates, and detailed workflows for converting external websites to Adobe Experience Manager Edge Delivery Services format. Includes webpage download automation, component templates, block generation helpers, and content structuring guides. Use when: working through the 4-step EDS conversion process (download, analyze, build, generate)."
---

# EDS Website Conversion Skill

This skill provides scripts, templates, and detailed guidance for converting external websites to Adobe Experience Manager Edge Delivery Services (EDS) format. It ensures pixel-perfect parity with source websites through a structured 4-step workflow.

## Quick Start

```bash
# Navigate to workspace root
cd /path/to/aem-eds-workspace

# Step 1: Download website
bash .github/skills/eds-conversion/download-webpage.sh https://example.com

# Step 2: Analyze (manual - review downloaded assets)
open downloads/

# Step 3: Build components
# Use Step 3 agent and component templates

# Step 4: Generate content
# Use Step 4 agent and content templates
```

## Available Assets in This Skill

### Scripts

- **download-webpage.sh** - Download complete website with all assets
- **validate-html.sh** - Validate generated HTML files
- **compare-images.sh** - Compare visual output with source

### Templates

- **block-template.js** - JavaScript component template
- **block-template.css** - CSS styling template
- **block-definition.json** - Block metadata template
- **page-template.html** - Content page template
- **conversion-plan-template.md** - Conversion Plan template

### Guides

- Complete workflow documentation
- Block patterns reference
- Content structure guidelines
- da.live integration steps

## Workflows

### Workflow 1: Quick Website Download

**When**: Need to capture website assets quickly

**Steps**:
1. Provide source URL
2. Run download script
3. Verify downloads folder
4. Proceed to analysis

**Tools Used**:
- `wget` command with mirroring option
- Manifest generation
- Asset verification

### Workflow 2: Component Building

**When**: Converting source design to EDS blocks

**Steps**:
1. Review Conversion Plan
2. Use JavaScript template for logic
3. Use CSS template for styling
4. Test locally with `npm run build`
5. Compare with source site

**Key Templates Provided**:
- Block component structure
- Event handling patterns
- Responsive design patterns
- Accessibility helpers

### Workflow 3: Content Generation

**When**: Creating da.live-ready HTML pages

**Steps**:
1. Extract content from source pages
2. Use page template to structure content
3. Reference block definitions
4. Validate HTML structure
5. Test visual rendering

**Output**:
- Browser-ready HTML files
- Image assets
- Content mapping documentation

## File Structure

```
.github/skills/eds-conversion/
├── SKILL.md                          # This file
├── download-webpage.sh               # Download script
├── validate-html.sh                  # HTML validation
├── compare-images.sh                 # Visual comparison
└── templates/
    ├── block-template.js             # Generic block JS
    ├── block-template.css            # Generic block CSS
    ├── block-definition.json         # Block metadata
    ├── page-template.html            # Content page
    ├── conversion-plan-template.md   # Planning doc
    └── accessibility-checklist.md    # QA checklist
```

## Key Concepts

### EDS Blocks Structure

Each block is a modular component that can be reused across pages:

```
Block = HTML container + CSS styling + JavaScript behavior
```

**Required files**:
- `{name}.js` - Component initialization
- `{name}.css` - Styling
- `_{name}.json` - Metadata

### Content Flow

```
Source Website → Download → Analyze → Plan
                                ↓
                          Build Blocks
                                ↓
                          Generate Content
                                ↓
                          Paste into da.live
                                ↓
                          Deploy via AEM Code Sync
```

### Pixel-Perfect Requirements

- Layout matches source exactly
- Colors accurate to source palette
- Typography (fonts, sizes) matches
- Spacing and alignment precise
- All interactive behaviors function identically
- Responsive breakpoints match source

## When to Use Each Workflow

| Scenario | Workflow | Agents Needed |
|----------|----------|---|
| Converting single website | Complete (1→4) | All 4 + orchestrator |
| Adding pages to existing site | Steps 2-4 | Analysis, Builder, Generator |
| Updating existing blocks | Step 3 only | Component Builder |
| Content-only updates | Step 4 only | Content Generator |
| Troubleshooting visual issues | Re-run Step 3 | Component Builder |

## Common Tasks with Solutions

### Task: Download website with authentication
**Solution**: Use curl with cookies instead of wget
```bash
curl https://example.com --cookie "auth_token=xxx"
```

### Task: Download JavaScript-rendered content
**Solution**: Use headless browser
```bash
# Install puppeteer or playwright
npx puppeteer-cli screenshot https://example.com
```

### Task: Convert single-page app (SPA)
**Solution**: Manually list all routes
```bash
# Download each route separately
wget https://example.com/
wget https://example.com/about
wget https://example.com/services
```

### Task: Validate all generated content
**Solution**: Use included validation script
```bash
bash .github/skills/eds-conversion/validate-html.sh eds-html/
```

### Task: Compare visual output with source
**Solution**: Use image comparison script
```bash
bash .github/skills/eds-conversion/compare-images.sh \
  downloads/example-com/screenshot.png \
  eds-html/screenshot.png
```

## Integration with Main Agents

This skill is referenced by:

1. **EDS Converter Main (Orchestrator)** - Coordinates all steps
2. **Download Agent** - Uses download-webpage.sh script
3. **Analysis Agent** - References planning templates
4. **Component Builder** - Uses block templates and patterns
5. **Content Generator** - Uses page templates and validation

## Performance Tips

- **Large sites**: Download overnight (use `--wait=1` to be respectful)
- **Limited bandwidth**: Use `--limit-rate=250k` to throttle
- **Many images**: Consider separate image optimization script
- **Components**: Build in dependency order (layout blocks first)

## Accessibility Requirements

All generated content must meet:

- ✅ WCAG 2.1 Level AA compliance
- ✅ Semantic HTML structure
- ✅ Descriptive alt text on images
- ✅ Keyboard navigation support
- ✅ Color contrast 4.5:1 (text), 3:1 (UI)
- ✅ ARIA landmarks and labels
- ✅ Focus indicators visible

## Troubleshooting

### Download Incomplete
- Check network connection
- Verify domain is accessible
- Check for authentication requirements
- Review robots.txt restrictions

### Missing Assets
- Verify same-domain requirement
- Check for CDN resources (external)
- Look for JavaScript-loaded images
- Check file permissions

### Visual Mismatch
- Compare CSS specificity
- Verify responsive breakpoints
- Check for custom fonts loading
- Inspect browser console for errors

### Accessibility Issues
- Add missing alt text
- Fix color contrast issues
- Add ARIA labels
- Test with screen reader

## Related Resources

- [EDS Conversion Main Agent](../agents/eds-converter-main.agent.md)
- [Download Agent](../agents/step-1-download.agent.md)
- [Analysis Agent](../agents/step-2-analyze.agent.md)
- [Component Builder Agent](../agents/step-3-build-components.agent.md)
- [Content Generator Agent](../agents/step-4-generate-content.agent.md)
- [AEM Boilerplate Docs](https://github.com/adobe/aem-boilerplate)
- [EDS Documentation](https://www.aem.live/)

## Success Metrics

A successful EDS conversion achieves:

1. ✅ **Visual Parity**: Source and converted site look identical
2. ✅ **Functional Parity**: All interactions work the same
3. ✅ **Accessibility**: WCAG 2.1 AA compliant
4. ✅ **Performance**: Fast load times, optimized assets
5. ✅ **Code Quality**: Clean, maintainable, documented
6. ✅ **Deployment Ready**: Committed, tested, ready for AEM

---

**Next Step**: Choose an agent based on your current stage in the workflow.
- Starting fresh? Use the **orchestrator agent** (`/eds-converter`)
- At a specific step? Use the **step agent** directly
