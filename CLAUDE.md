# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Personal website for kurotych.com built with Hugo static site generator using the PaperMod theme.

## Commands

```bash
# Initial setup (required after cloning)
git submodule init
git submodule update

# Local development server
hugo serve

# Create a new blog post
hugo new posts/my-post-name.md

# Build for production
hugo --minify
```

## Architecture

- **Hugo site** with PaperMod theme (git submodule at `themes/PaperMod`)
- **MkDocs submodule** at `programming-python-2sem/` - builds separately and deploys to `/ua/courses/programming-2sem/` path
- **GitHub Actions** deploys to GitHub Pages on push to main (`.github/workflows/gh-pages.yml`)

### Multilingual Setup

Site supports English (default) and Ukrainian (`ua`):
- English content: `content/posts/example.md`, `content/about/_index.md`
- Ukrainian content: `content/posts/example.ua.md`, `content/about/_index.ua.md`
- Ukrainian URLs use `/ua/` prefix (e.g., `/ua/about/`)
- Translations configured in `i18n/en.yaml` and `i18n/ua.yaml`

### Directory Structure

- `content/posts/` - Blog posts in Markdown (`.md` for English, `.ua.md` for Ukrainian)
- `content/about/` - About page
- `content/certificates/` - Certificates page
- `content/courses/` - Courses page (Ukrainian only)
- `layouts/partials/` - Custom Hugo partials overriding PaperMod theme
- `layouts/shortcodes/` - Custom shortcodes (e.g., `details.html` for collapsible sections)
- `static/` - Static assets (images, PDF, CNAME)
- `assets/css/` - Custom CSS extending theme styles

### Configuration

Main config in `config.toml`:
- Base URL: `https://kurotych.com`
- Theme: PaperMod
- Goldmark renderer with `unsafe = true` for raw HTML in Markdown
