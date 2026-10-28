# Simon’s blog

Markdown, two layouts, one stylesheet. Published at <https://xenogon.github.io/>.

## Write and publish

1. Copy `drafts/_template.md` to `drafts/my-post.md` and write in Markdown.
2. When ready, move it to `_posts/YYYY-MM-DD-my-post.md`, using today's date.
3. Open a pull request and merge it into `main`.

That’s it. GitHub builds and deploys the blog using Jekyll. You can do everything
in GitHub’s web editor; nothing needs to be installed to write or publish.

The filename sets the publication date and URL: `_posts/2026-10-25-my-post.md`
becomes `https://xenogon.github.io/posts/my-post/`. Only a title is needed in the
front matter. Future-dated posts stay unpublished until a build on or after
that date; there is no scheduled publishing.

`drafts/` is excluded from the generated site, including images and attachments.
Draft-only changes also skip deployment. Committed drafts are still publicly
readable on GitHub. Put published images in `assets/` and link to them with
`![Description](/assets/my-image.jpg)`.

## Local preview, including drafts

Double-click `preview.command` in Finder, or run:

```sh
./preview.command
```

The first run installs the preview dependencies into the ignored `vendor/`
folder. It then opens <http://localhost:4000/> in your browser. Published posts
and drafts appear together, with drafts labelled **Draft**. Save a Markdown
file and the browser refreshes automatically. Leave the Terminal window open;
press **Ctrl+C** to stop the preview.

Keep writing in `drafts/`; there is no need to move or rename a file to preview
it. The template stays hidden. Normal builds and deployments exclude drafts.

With the preview dependencies installed, run `ruby test_site.rb` to check
publication and preview.

## Files

- `_posts/` — published Markdown posts.
- `drafts/` — unfinished writing and the template.
- `index.html`, `_layouts/`, `assets/` — homepage, layouts and styling.
- `_config.yml` — site settings and draft exclusion.
- `preview.command`, `Gemfile` — local preview and its dependencies.
- `.github/workflows/pages.yml` — build and deploy on site changes merged to `main`.

Existing post URLs and the feed URL `/index.xml` are preserved. Unused Hugo tag
and category archive pages have been removed. GitHub Pages already uses Actions;
no hosting setting needs to change when this migration is merged.
