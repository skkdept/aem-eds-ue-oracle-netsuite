#!/bin/bash

################################################################################
# Download Webpage Script
# 
# Usage: ./download-webpage.sh <URL> [folder-name]
# 
# Example:
#   ./download-webpage.sh https://example.com
#   ./download-webpage.sh https://example.com my-site-2025
#
# This script downloads a complete website with all assets (HTML, CSS, JS, 
# images) into a downloads folder structure suitable for EDS conversion.
################################################################################

set -e  # Exit on error

# Color codes for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if URL provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: No URL provided${NC}"
    echo "Usage: $0 <URL> [folder-name]"
    echo "Example: $0 https://example.com"
    exit 1
fi

SOURCE_URL="$1"
FOLDER_NAME="${2:-$(date +%Y-%m-%d)}"
ROOT_DIR="$(cd "$(dirname "$0")" && pwd)/../../.."
DOWNLOAD_DIR="${ROOT_DIR}/downloads/${FOLDER_NAME}"

echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${BLUE}EDS Website Downloader${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "Source URL:     ${GREEN}${SOURCE_URL}${NC}"
echo -e "Download folder: ${GREEN}${DOWNLOAD_DIR}${NC}"
echo ""

# Validate URL format
if ! [[ "$SOURCE_URL" =~ ^https?:// ]]; then
    echo -e "${RED}Error: URL must start with http:// or https://${NC}"
    exit 1
fi

# Extract domain from URL
DOMAIN=$(echo "$SOURCE_URL" | sed -E 's|https?://([^/]+).*|\1|')
echo -e "Domain:         ${GREEN}${DOMAIN}${NC}"
echo ""

# Create download directory
mkdir -p "$DOWNLOAD_DIR"
cd "$DOWNLOAD_DIR"

echo -e "${YELLOW}Starting download...${NC}"
echo ""

# Download website with wget
# Options explained:
# --mirror: Recursive download (creates website mirror)
# --convert-links: Convert links to local references
# --adjust-extension: Add .html extension to files
# --page-requisites: Download CSS, JS, images needed for pages
# --no-parent: Don't go to parent directories
# --domains: Only download from specified domain
# --wait: Delay between requests (be respectful to server)
# --limit-rate: Limit download speed
# --user-agent: Spoof user agent (some sites reject wget)
# --exclude: Exclude certain file types/directories

wget \
  --mirror \
  --convert-links \
  --adjust-extension \
  --page-requisites \
  --no-parent \
  --domains="${DOMAIN}" \
  --wait=0.5 \
  --limit-rate=500k \
  --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
  --exclude-directories="/.git,/.github,/node_modules,/dist,/build,.well-known" \
  --exclude="*.zip,*.tar,*.gz,*.exe,*.dmg" \
  --reject="xml,rss" \
  -v \
  "$SOURCE_URL" || true

echo ""
echo -e "${YELLOW}Download complete!${NC}"
echo ""

# Generate manifest
echo -e "${BLUE}Generating manifest...${NC}"

# Save file listing
echo "# File Manifest - Generated $(date)" > DOWNLOAD_MANIFEST.txt
echo "# Source: $SOURCE_URL" >> DOWNLOAD_MANIFEST.txt
echo "# Domain: $DOMAIN" >> DOWNLOAD_MANIFEST.txt
echo "# Downloaded: $(date)" >> DOWNLOAD_MANIFEST.txt
echo "" >> DOWNLOAD_MANIFEST.txt
find . -type f | sort >> DOWNLOAD_MANIFEST.txt

# Generate statistics
{
    echo "# Download Statistics"
    echo ""
    echo "| Metric | Count |"
    echo "|--------|-------|"
    echo "| HTML Files | $(find . -name '*.html' | wc -l) |"
    echo "| CSS Files | $(find . -name '*.css' | wc -l) |"
    echo "| JavaScript Files | $(find . -name '*.js' | wc -l) |"
    echo "| Images (JPG/PNG/GIF/WebP) | $(find . -type f \( -name '*.jpg' -o -name '*.jpeg' -o -name '*.png' -o -name '*.gif' -o -name '*.webp' \) | wc -l) |"
    echo "| SVG Files | $(find . -name '*.svg' | wc -l) |"
    echo "| Font Files (WOFF/TTF/OTF) | $(find . -type f \( -name '*.woff*' -o -name '*.ttf' -o -name '*.otf' \) | wc -l) |"
    echo "| JSON Files | $(find . -name '*.json' | wc -l) |"
    echo "| Total Files | $(find . -type f | wc -l) |"
    echo "| Total Size | $(du -sh . | cut -f1) |"
    echo ""
    echo "## Download Notes"
    echo ""
    echo "- Downloaded from: $SOURCE_URL"
    echo "- Domain restricted to: $DOMAIN"
    echo "- Downloaded on: $(date)"
    echo "- Download delay: 0.5 seconds between requests"
    echo ""
    echo "## Next Steps"
    echo ""
    echo "1. Open downloaded HTML files in a browser to verify"
    echo "2. Check for missing assets or broken links"
    echo "3. Review downloaded structure"
    echo "4. Proceed to Step 2: Analyze"
} > DOWNLOAD_NOTES.md

echo -e "${GREEN}✓ Manifest saved to DOWNLOAD_MANIFEST.txt${NC}"
echo -e "${GREEN}✓ Statistics saved to DOWNLOAD_NOTES.md${NC}"
echo ""

# List main HTML files found
echo -e "${BLUE}HTML Files Found:${NC}"
find . -maxdepth 3 -name '*.html' -type f | head -20

echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✓ Download Complete!${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "Location: ${GREEN}${DOWNLOAD_DIR}${NC}"
echo ""
echo "Next steps:"
echo "1. Review downloaded files: open $DOWNLOAD_DIR"
echo "2. Test HTML files in browser to verify appearance"
echo "3. Check for missing assets in browser console"
echo "4. Document any issues in DOWNLOAD_NOTES.md"
echo "5. Proceed to Step 2: Analyze (inspect the downloaded site)"
echo ""
