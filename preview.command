#!/bin/sh
set -eu
cd "$(dirname "$0")"
export GEM_HOME="$PWD/vendor/gems"
export GEM_PATH="$GEM_HOME"
export PATH="$GEM_HOME/bin:$PATH"
export BUNDLE_GEMFILE="$PWD/Gemfile"

if ! gem list --local --exact --installed bundler --version 2.4.22 >/dev/null; then
  gem install bundler --version 2.4.22 --no-document --clear-sources --source https://rubygems.org
fi
bundle _2.4.22_ check >/dev/null 2>&1 || bundle _2.4.22_ install
[ -e _drafts ] || ln -s drafts _drafts
# Log the harmless duplicate-watch notice from the draft-folder link.
export LISTEN_GEM_ADAPTER_WARN_BEHAVIOR=log
exec bundle _2.4.22_ exec jekyll serve --drafts --livereload --open-url
