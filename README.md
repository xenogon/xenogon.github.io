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

## Optional local preview

With Ruby and [Jekyll](https://jekyllrb.com/docs/installation/) installed:

```sh
gem install github-pages -v 232 --no-document
jekyll serve
```

Open <http://localhost:4000/>. To preview unfinished writing, temporarily move it
into `_posts/` with a dated filename, then move it back before merging.
Run `ruby test_site.rb` to check publication, existing URLs, feeds and exclusions.

## Files

- `_posts/` — published Markdown posts.
- `drafts/` — unfinished writing and the template.
- `index.html`, `_layouts/`, `assets/` — homepage, layouts and styling.
- `_config.yml` — site settings and draft exclusion.
- `.github/workflows/pages.yml` — build and deploy on site changes merged to `main`.

Existing post URLs and the feed URL `/index.xml` are preserved. Unused Hugo tag
and category archive pages have been removed. GitHub Pages already uses Actions;
no hosting setting needs to change when this migration is merged.
