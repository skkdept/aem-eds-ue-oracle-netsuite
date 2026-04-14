#!/usr/bin/env python3
"""
Fetch AEM Block Collection from adobe/aem-block-collection GitHub repo.

Saves blocks locally so agents (Copilot or Claude Code) can look up
existing implementations without needing internet access at runtime.

Usage:
    python3 scripts/fetch-block-collection.py

Output:
    .github/skills/eds-conversion/block-collection/
    ├── index.json          — manifest of all available blocks
    ├── hero/
    │   ├── hero.js
    │   └── hero.css
    ├── cards/
    │   ├── cards.js
    │   └── cards.css
    └── ...
"""

import json
import os
import time
import urllib.request
import urllib.error
from pathlib import Path

GITHUB_API = "https://api.github.com/repos/adobe/aem-block-collection/contents/blocks"
RAW_BASE = "https://raw.githubusercontent.com/adobe/aem-block-collection/main/blocks"
OUTPUT_DIR = Path(__file__).parent.parent / ".github" / "skills" / "eds-conversion" / "block-collection"


def fetch_json(url: str) -> dict | list | None:
    """Fetch JSON from a URL. Returns None on failure."""
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "aem-eds-fetch/1.0"})
        with urllib.request.urlopen(req, timeout=15) as resp:
            return json.loads(resp.read().decode())
    except urllib.error.HTTPError as e:
        if e.code == 403:
            print(f"  [rate-limited] {url} — add GITHUB_TOKEN env var to avoid rate limits")
        else:
            print(f"  [http {e.code}] {url}")
        return None
    except Exception as e:
        print(f"  [error] {url}: {e}")
        return None


def fetch_text(url: str) -> str | None:
    """Fetch raw text from a URL. Returns None on failure."""
    try:
        req = urllib.request.Request(url, headers={"User-Agent": "aem-eds-fetch/1.0"})
        with urllib.request.urlopen(req, timeout=15) as resp:
            return resp.read().decode("utf-8", errors="replace")
    except Exception as e:
        print(f"  [error] {url}: {e}")
        return None


def get_github_headers() -> dict:
    """Build request headers, using GITHUB_TOKEN if available."""
    headers = {"User-Agent": "aem-eds-fetch/1.0"}
    token = os.environ.get("GITHUB_TOKEN")
    if token:
        headers["Authorization"] = f"Bearer {token}"
    return headers


def fetch_json_with_auth(url: str) -> dict | list | None:
    """Fetch JSON with optional GitHub auth token."""
    try:
        req = urllib.request.Request(url, headers=get_github_headers())
        with urllib.request.urlopen(req, timeout=15) as resp:
            return json.loads(resp.read().decode())
    except urllib.error.HTTPError as e:
        if e.code == 403:
            print(f"  [rate-limited] Add GITHUB_TOKEN env var: export GITHUB_TOKEN=your_token")
        elif e.code == 404:
            print(f"  [not found] {url}")
        else:
            print(f"  [http {e.code}] {url}")
        return None
    except Exception as e:
        print(f"  [error] {url}: {e}")
        return None


def list_blocks() -> list[dict]:
    """List all block folders from the GitHub repo."""
    print(f"Fetching block list from {GITHUB_API} ...")
    data = fetch_json_with_auth(GITHUB_API)
    if not data or not isinstance(data, list):
        print("Failed to fetch block list. Check network or GITHUB_TOKEN.")
        return []
    return [item for item in data if item.get("type") == "dir"]


def download_block(block_name: str, block_dir: Path) -> dict:
    """
    Download JS and CSS for a block. Returns a dict with metadata.
    """
    block_dir.mkdir(parents=True, exist_ok=True)
    files_saved = []

    for ext in ("js", "css"):
        filename = f"{block_name}.{ext}"
        url = f"{RAW_BASE}/{block_name}/{filename}"
        content = fetch_text(url)
        if content:
            (block_dir / filename).write_text(content, encoding="utf-8")
            files_saved.append(filename)
        # Brief pause to avoid hammering GitHub
        time.sleep(0.1)

    return {
        "name": block_name,
        "files": files_saved,
        "source": f"https://github.com/adobe/aem-block-collection/tree/main/blocks/{block_name}",
        "example": f"https://main--aem-block-collection--adobe.aem.live/blocks/{block_name}/{block_name}",
    }


def main():
    OUTPUT_DIR.mkdir(parents=True, exist_ok=True)
    print(f"Output directory: {OUTPUT_DIR}\n")

    blocks = list_blocks()
    if not blocks:
        print("No blocks found. Exiting.")
        return

    print(f"Found {len(blocks)} blocks. Downloading JS + CSS...\n")

    index = []
    for i, block_entry in enumerate(blocks, 1):
        block_name = block_entry["name"]
        block_dir = OUTPUT_DIR / block_name
        print(f"[{i}/{len(blocks)}] {block_name}")
        meta = download_block(block_name, block_dir)
        if meta["files"]:
            print(f"  ✓ saved: {', '.join(meta['files'])}")
        else:
            print(f"  ✗ no files found (block may be JS-only or have different structure)")
        index.append(meta)

    # Write index.json
    index_path = OUTPUT_DIR / "index.json"
    index_path.write_text(json.dumps(index, indent=2), encoding="utf-8")
    print(f"\n✓ index.json written with {len(index)} blocks")

    # Summary
    reusable = [b for b in index if b["files"]]
    print(f"✓ {len(reusable)} blocks with downloadable code")
    print(f"\nBlock Collection cached at:\n  {OUTPUT_DIR}")
    print("\nAgents can now check index.json to decide REUSE vs BUILD for each block.")
    print("Re-run this script to refresh the cache.")


if __name__ == "__main__":
    main()
