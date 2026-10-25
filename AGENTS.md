# Agent Guidelines

Brief notes for AI agents working on this repo.

## Workflow

- Use `gh` CLI for GitHub operations (commits, pushes, repo management)
- Preview changes locally with `jekyll serve` before pushing
- Commit in logical chunks with clear messages

## Cost Awareness

- GitHub Actions minutes are metered - avoid unnecessary pushes that trigger workflows
- Don't provision Codespaces, Packages, or other usage-priced GitHub features without explicit approval
- Batch related changes into single commits when practical

## Security

- Never install packages via pip/npm without verifying the source
- No untrusted dependencies - check package popularity, maintenance status, and known vulnerabilities
- Don't expose secrets, tokens, or personal information in code or config
- Keep the repo public-safe: assume all code is visible to everyone
- Don't modify `.git/` or bypass branch protections

## Blog Structure

- Templates go in `_layouts/`
- Styles go in `assets/site.css`
- Config lives in `_config.yml`
- Published posts are `_posts/YYYY-MM-DD-slug.md`
- Drafts go in `drafts/`, which must remain excluded from site builds
- Run `ruby test_site.rb` after changing templates, config, or publishing

## Local Development

- Run `jekyll serve` for live preview
- Site deploys automatically on push to `main` via GitHub Actions
