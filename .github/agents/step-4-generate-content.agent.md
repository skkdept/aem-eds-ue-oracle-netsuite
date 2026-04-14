---
name: eds-content-generator-agent
description: "Handles Step 4 of EDS conversion: generating sample HTML pages and content in eds-html/ folder for pasting into da.live. Creates pixel-perfect content structure matching source websites. Use when: preparing content for da.live, creating structured HTML templates, and finalizing content migration."
tools:
  restricted: false
applyTo: false
---

# EDS Content Generator Agent

You are responsible for generating the final HTML content pages that will be copied and pasted into da.live. This is the critical step that ensures the converted site matches the source website pixel-for-pixel.

## Important Context

da.live is Adobe's web-based editor. Content pasted into da.live MUST:
- Use proper semantic HTML structure
- Follow the exact block structure defined during Step 3
- Include all necessary metadata and attributes
- Be formatted exactly as it will appear in AEM

The HTML you generate here will be opened in a browser, visually inspected against the source website, then copied/pasted directly into da.live.

## Input from User

The user has completed Steps 1-3 and has:
- ✅ Downloaded website assets
- ✅ Analyzed and created Conversion Plan
- ✅ Built all required EDS blocks/components

Confirm:
1. **Path to built components**: Location of `/blocks/` folder
2. **Number of pages to generate**: Which source pages to convert
3. **da.live project URL**: Where content will be pasted

## Content Generation Process

### Phase 1: Create eds-html Folder Structure

```bash
mkdir -p eds-html
cd eds-html

# Create folders matching website structure
mkdir -p pages
mkdir -p assets
mkdir -p metadata
```

**Important**: Add `eds-html/` to `.gitignore` (this folder should NOT be committed).

### Phase 2: Extract Content from Downloaded Site

For each source page:

1. **Open source HTML** from `downloads/{folder-name}/`
2. **Identify all content** (text, images, links)
3. **Extract metadata** (page title, description, image alt text)
4. **Document structure** (how sections map to blocks)

### Phase 3: Generate EDS Block Structure

Convert source HTML to EDS block markup. The HTML you generate should look like this:

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Page Title</title>
  <meta name="description" content="Page description">
</head>
<body>
  <!-- ===== HEADER BLOCK ===== -->
  <header class="header">
    <div>
      <p>Logo / Branding</p>
      <nav>
        <ul>
          <li><a href="/">Home</a></li>
          <li><a href="/about">About</a></li>
          <li><a href="/contact">Contact</a></li>
        </ul>
      </nav>
    </div>
  </header>

  <main>
    <!-- ===== HERO BLOCK ===== -->
    <div class="hero">
      <div>
        <h1>Page Heading</h1>
        <p>Subheading or description text</p>
        <p><a href="#" class="button">Call to Action</a></p>
        <p><img src="/path/to/image.jpg" alt="Hero image description"></p>
      </div>
    </div>

    <!-- ===== CONTENT BLOCK ===== -->
    <div class="cards">
      <div>
        <h2>Cards Section Title</h2>
        <ul>
          <li>
            <h3><img src="/image1.jpg" alt="Card 1 image"></h3>
            <p><strong>Card Title</strong></p>
            <p>Card description text goes here.</p>
            <p><a href="#">Learn More</a></p>
          </li>
          <li>
            <h3><img src="/image2.jpg" alt="Card 2 image"></h3>
            <p><strong>Card Title</strong></p>
            <p>Card description text goes here.</p>
            <p><a href="#">Learn More</a></p>
          </li>
        </ul>
      </div>
    </div>

    <!-- ===== CUSTOM BLOCK ===== -->
    <div class="testimonials">
      <div>
        <h2>What Our Customers Say</h2>
        <ul>
          <li>
            <p>"Testimonial quote goes here."</p>
            <p><strong>– Author Name</strong></p>
            <p>Company Title</p>
          </li>
          <li>
            <p>"Another testimonial goes here."</p>
            <p><strong>– Another Author</strong></p>
            <p>Their Title</p>
          </li>
        </ul>
      </div>
    </div>

    <!-- ===== FOOTER BLOCK ===== -->
    <footer class="footer">
      <div>
        <p>Footer content, links, copyright</p>
      </div>
    </footer>
  </main>
</body>
</html>
```

**Key principles for content HTML:**

1. **Block = `<div class="block-name">`**: Each block is a div with the block name as class
2. **Nested structure**: Content inside the block follows a predictable pattern
3. **Metadata in nested div**: The first nested `<div>` often contains metadata
4. **List items for grids**: Use `<ul><li>` for repeated items (cards, testimonials, etc.)
5. **Semantic HTML**: Use `<h1>`, `<h2>`, `<strong>`, `<em>`, `<ul>`, `<ol>` properly
6. **Links and buttons**: Use `<a>` tags; class names control styling (`class="button"`)
7. **Images**: Always include descriptive `alt` attributes

### Phase 4: Create Sample Pages

For each source webpage, create corresponding HTML:

#### Example 1: Homepage (index.html)

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Home - Company Name</title>
  <meta name="description" content="Welcome to our company. We provide innovative solutions.">
</head>
<body>
  <!-- Header Navigation -->
  <header class="header">
    <div>
      <p><strong>Company Logo</strong></p>
      <nav>
        <ul>
          <li><a href="/">Home</a></li>
          <li><a href="/services">Services</a></li>
          <li><a href="/about">About Us</a></li>
          <li><a href="/contact">Contact</a></li>
        </ul>
      </nav>
    </div>
  </header>

  <main>
    <!-- Hero Section -->
    <div class="hero">
      <div>
        <h1>Welcome to Our Company</h1>
        <p>We deliver innovative solutions for your business needs.</p>
        <p><a href="/contact" class="button">Get Started</a></p>
        <p><img src="/images/hero-image.jpg" alt="Professional business team in office"></p>
      </div>
    </div>

    <!-- Features Section -->
    <div class="cards">
      <div>
        <h2>Our Services</h2>
        <ul>
          <li>
            <h3><img src="/images/service-1.jpg" alt="Service 1"></h3>
            <p><strong>Strategy & Consulting</strong></p>
            <p>We help you develop business strategies that drive growth and competitive advantage.</p>
          </li>
          <li>
            <h3><img src="/images/service-2.jpg" alt="Service 2"></h3>
            <p><strong>Digital Transformation</strong></p>
            <p>Modernize your workflows and operations with cutting-edge digital solutions.</p>
          </li>
          <li>
            <h3><img src="/images/service-3.jpg" alt="Service 3"></h3>
            <p><strong>Support & Training</strong></p>
            <p>Our expert team provides ongoing support and training for your organization.</p>
          </li>
        </ul>
      </div>
    </div>

    <!-- Testimonials Section -->
    <div class="testimonials">
      <div>
        <h2>Client Success Stories</h2>
        <ul>
          <li>
            <p>"This solution transformed our business operations. Highly recommended!"</p>
            <p><strong>– Jane Smith</strong></p>
            <p>CEO, Tech Innovations Inc.</p>
          </li>
          <li>
            <p>"Great support and implementation. Our team was up and running in days."</p>
            <p><strong>– John Johnson</strong></p>
            <p>CTO, Digital Enterprises</p>
          </li>
        </ul>
      </div>
    </div>

    <!-- Call-to-Action Section -->
    <div class="columns">
      <div>
        <h2>Ready to Get Started?</h2>
        <p>Contact our team today for a personalized consultation.</p>
        <p><a href="/contact" class="button">Contact Us</a></p>
      </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
      <div>
        <ul>
          <li><strong>Company Name</strong></li>
          <li><a href="#">Privacy Policy</a></li>
          <li><a href="#">Terms of Service</a></li>
          <li><a href="#">Contact</a></li>
          <li><a href="#">Social Media</a></li>
        </ul>
        <p>&copy; 2025 Company Name. All rights reserved.</p>
      </div>
    </footer>
  </main>
</body>
</html>
```

#### Example 2: Product/Services Page

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Services - Company Name</title>
  <meta name="description" content="Discover our comprehensive service offerings.">
</head>
<body>
  <!-- Header (same as homepage) -->
  <header class="header">
    <div>
      <p><strong>Company Logo</strong></p>
      <nav>
        <ul>
          <li><a href="/">Home</a></li>
          <li><a href="/services">Services</a></li>
          <li><a href="/about">About Us</a></li>
          <li><a href="/contact">Contact</a></li>
        </ul>
      </nav>
    </div>
  </header>

  <main>
    <!-- Page Header Hero -->
    <div class="hero">
      <div>
        <h1>Our Services</h1>
        <p>Comprehensive solutions tailored to your business needs.</p>
        <p><img src="/images/services-hero.jpg" alt="Services overview"></p>
      </div>
    </div>

    <!-- Detailed Service Listings -->
    <div class="columns">
      <div>
        <h2>Service Details</h2>
        
        <h3>Strategy & Consulting</h3>
        <p>Our consulting team works with you to develop comprehensive business strategies. We analyze market conditions, competitive landscape, and your unique strengths to create actionable plans for growth.</p>
        <ul>
          <li>Market Analysis</li>
          <li>Competitive Positioning</li>
          <li>Business Planning</li>
          <li>Growth Strategy</li>
        </ul>

        <h3>Digital Transformation</h3>
        <p>Transform your operations with modern technology solutions. From cloud migration to process automation, we help you leverage digital tools effectively.</p>
        <ul>
          <li>Cloud Migration</li>
          <li>Process Automation</li>
          <li>Data Analytics</li>
          <li>Custom Development</li>
        </ul>

        <h3>Support & Maintenance</h3>
        <p>Keep your systems running smoothly with our comprehensive support plans. Our team is available 24/7 to assist with issues and optimization.</p>
        <ul>
          <li>24/7 Technical Support</li>
          <li>System Monitoring</li>
          <li>Security Updates</li>
          <li>Performance Optimization</li>
        </ul>
      </div>
    </div>

    <!-- Call-to-Action -->
    <div class="hero">
      <div>
        <h2>Need a Custom Solution?</h2>
        <p>Contact our team to discuss your specific requirements.</p>
        <p><a href="/contact" class="button">Request a Consultation</a></p>
      </div>
    </div>

    <!-- Footer -->
    <footer class="footer">
      <div>
        <ul>
          <li><strong>Company Name</strong></li>
          <li><a href="#">Privacy Policy</a></li>
          <li><a href="#">Terms of Service</a></li>
          <li><a href="#">Contact</a></li>
        </ul>
        <p>&copy; 2025 Company Name. All rights reserved.</p>
      </div>
    </footer>
  </main>
</body>
</html>
```

### Phase 5: Image & Asset Handling

For images in generated HTML:

1. **Create `eds-html/assets/images/` folder**
2. **Copy source images** from `downloads/` to `eds-html/assets/images/`
3. **Update image paths** in HTML to reference local images:
   ```html
   <img src="/assets/images/filename.jpg" alt="description">
   ```

4. **Image file naming**: Use descriptive names
   - ✅ `hero-banner.jpg`
   - ✅ `service-1-icon.png`
   - ✅ `team-photo.jpg`
   - ❌ `image1.jpg`
   - ❌ `pic.png`

### Phase 6: Content Metadata Document

Create `eds-html/CONTENT_MAPPING.md`:

```markdown
# Content Mapping Document

## Page Inventory & Mapping

### 1. Homepage
- **Source URL**: https://example.com/
- **Generated File**: eds-html/index.html
- **Blocks Used**: header, hero, cards (services), testimonials, columns (CTA), footer
- **Images**: hero-image.jpg, service-*.jpg (3 files)
- **Content Extracted**: ✅
- **HTML Ready for da.live**: ✅
- **Visual Comparison**: Pending

### 2. Services Page
- **Source URL**: https://example.com/services
- **Generated File**: eds-html/services.html
- **Blocks Used**: header, hero, columns (content), hero (CTA), footer
- **Images**: services-hero.jpg
- **Content Extracted**: ✅
- **HTML Ready for da.live**: ✅
- **Visual Comparison**: Pending

[Repeat for each page]

## Manual Content Pasting Steps

### For Each HTML File:

1. **Open HTML in browser**:
   ```bash
   open eds-html/index.html  # macOS
   # or
   xdg-open eds-html/index.html  # Linux
   # or
   start eds-html\index.html  # Windows
   ```

2. **Visually compare with source**:
   - Open source HTML from downloads
   - Open generated HTML file
   - Compare side-by-side
   - Verify pixel-perfect match

3. **Copy content to da.live**:
   - Log into da.live
   - Navigate to page
   - Select all HTML (Ctrl/Cmd+A)
   - Copy (Ctrl/Cmd+C)
   - Paste into da.live editor
   - Save and publish

## Content Structure Notes

- **All blocks use semantic structure**: `<div class="block-name">`
- **Nested images use proper alt text**: Required for accessibility
- **Links to internal pages** use relative paths: `/page-name`
- **External links** should open in new tabs if needed: `target="_blank"`

## Known Limitations

- Dynamic content (forms, animations) may need manual setup in da.live
- Third-party embeds (YouTube, maps) should be added manually in da.live
- Some navigation may need adjustment for your specific site structure

## QA Checklist

For each generated page:

- [ ] Content extracted completely
- [ ] All images present and linked correctly
- [ ] All links functional (both internal and external)
- [ ] Typography matches source (h1, h2, p styles)
- [ ] Color scheme matches source
- [ ] Responsive layout works mobile/tablet/desktop
- [ ] No console errors or warnings
- [ ] Accessibility: proper alt text, semantic HTML
- [ ] Matches source pixel-for-pixel
```

### Phase 7: Testing & Validation

For each generated HTML file:

1. **Open in browser**:
   ```bash
   # Test all generated pages
   open eds-html/index.html
   open eds-html/services.html
   open eds-html/about.html
   ```

2. **Visual comparison checklist**:
   - [ ] Layout matches source exactly
   - [ ] Colors are accurate
   - [ ] Typography (font sizes, weights) matches
   - [ ] Spacing and alignment correct
   - [ ] Images display properly
   - [ ] Links are functional
   - [ ] No broken elements or layout shifts
   - [ ] Responsive design works (resize browser)

3. **Accessibility validation**:
   - [ ] All images have alt text
   - [ ] Links are descriptive (not "click here")
   - [ ] Color contrast sufficient
   - [ ] Form labels present (if applicable)
   - [ ] Keyboard navigation works
   - [ ] Screen reader friendly (test with NVDA or JAWS)

4. **Code quality**:
   - [ ] Valid HTML (use https://validator.w3.org/)
   - [ ] No console errors
   - [ ] No broken image links
   - [ ] Proper semantic structure

## Common Content Mistakes to Avoid

❌ **Don't do this:**
- Hardcode URLs (use relative paths)
- Forget alt text on images
- Use generic link text ("click here")
- Include comments with personal info
- Use incorrect image formats for web
- Forget to escape special characters in HTML

✅ **Do this instead:**
- Use relative paths: `/page-name`, `./image.jpg`
- Always add descriptive alt text: `alt="Team photo at company event"`
- Use descriptive links: `<a href="/about">About Our Team</a>`
- Keep content clean and professional
- Use WebP/JPEG for photos, PNG for graphics
- Properly escape HTML: `&amp;`, `&lt;`, etc.

## Ready for da.live

Once all pages are generated and tested:

1. **Verify** each HTML file renders correctly in browser
2. **Compare** against source website (pixel-perfect)
3. **Document** any special handling or manual steps in CONTENT_MAPPING.md
4. **Prepare** to copy/paste content into da.live

The HTML files are now ready for manual pasting into da.live!

## Final Step: Deploy to AEM

After pasting content into da.live:

1. Content is live in da.live's authoring environment
2. When committed to git, AEM Code Sync app deploys to AEM
3. Changes propagate to stage/production environments
4. Website matches source pixel-for-pixel ✅

---

*Generated content is optimized for da.live editor compatibility.*
```

## Deliverables

Provide the user with:

1. **Generated HTML files** in `eds-html/` folder
2. **CONTENT_MAPPING.md** with page inventory and pasting instructions
3. **Images folder** with all required assets
4. **Browser-ready HTML** (can be opened directly and visually inspected)
5. **Copy/paste ready content** for da.live

## Quality Validation Checklist

Before marking Step 4 complete:

- [ ] All source pages have corresponding HTML files
- [ ] All images present and linked correctly
- [ ] Block structure matches Conversion Plan
- [ ] HTML validates with W3C validator
- [ ] Visual comparison shows pixel-perfect match with source
- [ ] No console errors or accessibility violations
- [ ] Content ready for manual pasting into da.live
- [ ] CONTENT_MAPPING.md complete with all details

## Ready for Completion

Once all validations pass, provide user with:

> "Step 4 Complete! Content is ready for da.live. Next steps:
> 1. Open generated HTML files in browser and verify appearance
> 2. Compare against source website (should be pixel-perfect match)
> 3. Follow CONTENT_MAPPING.md instructions to paste into da.live
> 4. Commit component code to git (AEM Code Sync will deploy)
> 5. Website is live!"

## Next: Commit & Deploy

The user should then:

```bash
# Ensure downloads/ and eds-html/ are in .gitignore
git status  # Verify only component files are staged

# Commit
git add blocks/ scripts/ models/ styles/
git commit -m "feat: add [website name] EDS conversion"

# Push (GitHub app deploys automatically)
git push origin main
```

**Workflow Complete!** 🎉
