require "fileutils"
require "tmpdir"
require "jekyll"
require "rexml/document"

def check(condition, message)
  raise message unless condition
end

ENV["JEKYLL_ENV"] = "production"
Dir.mktmpdir("blog-check-") do |directory|
  directory = File.realpath(directory)
  source = File.join(directory, "source")
  output = File.join(directory, "output")
  FileUtils.mkdir_p(source)
  ignored = %w[.git _site .jekyll-cache .bundle vendor public resources]
  Dir.children(__dir__).reject { |name| ignored.include?(name) }.each do |name|
    FileUtils.cp_r(File.join(__dir__, name), source)
  end
  File.write(File.join(source, "drafts", "private.md"), "---\ntitle: [invalid YAML\n---\nPRIVATE_DRAFT_SENTINEL")
  File.write(File.join(source, "drafts", "attachment.txt"), "PRIVATE_ATTACHMENT_SENTINEL")
  File.write(File.join(source, "_posts", "2000-01-01-publication-check.md"), <<~MARKDOWN)
    ---
    title: "<em>Publication & check</em>"
    ---
    **PUBLICATION_SENTINEL**
  MARKDOWN
  File.write(File.join(source, "_posts", "2999-01-01-future-check.md"), "---\ntitle: Future\n---\nFUTURE_POST_SENTINEL")
  config = Jekyll.configuration("source" => source, "destination" => output,
                                "config" => File.join(source, "_config.yml"),
                                "strict_front_matter" => true, "quiet" => true, "safe" => true,
                                "whitelist" => %w[jekyll-feed jekyll-sitemap])
  Dir.chdir(source) { Jekyll::Site.new(config).process }
  home = File.read(File.join(output, "index.html"))
  %w[funnel-data-platform-rebuild building-personal-productivity-tool publication-check].each do |slug|
    url = "/posts/#{slug}/"
    page = File.read(File.join(output, url, "index.html"))
    check(home.include?(url), "Missing homepage link: #{url}")
    check(page.include?(%(<link rel="canonical" href="https://xenogon.github.io#{url}">)), "Wrong canonical URL: #{url}")
    %w[index.xml sitemap.xml].each do |feed|
      xml = File.read(File.join(output, feed))
      REXML::Document.new(xml)
      check(xml.include?("https://xenogon.github.io#{url}"), "Missing #{feed} entry: #{url}")
    end
  end
  post = File.read(File.join(output, "posts/publication-check/index.html"))
  check(post.include?("<strong>PUBLICATION_SENTINEL</strong>"), "Markdown did not render")
  check(post.include?("&lt;em&gt;Publication &amp; check&lt;/em&gt;"), "Post title was not escaped")
  check(home.include?("&lt;em&gt;Publication &amp; check&lt;/em&gt;"), "Homepage title was not escaped")
  check(File.file?(File.join(output, "404.html")), "Missing 404 page")
  check(File.file?(File.join(output, "assets/site.css")), "Missing stylesheet")
  check(File.file?(File.join(output, "assets/img/author.jpg")), "Missing portrait")
  %w[drafts README.md AGENTS.md test_site.rb].each do |name|
    check(!File.exist?(File.join(output, name)), "Source file leaked: #{name}")
  end
  Dir.glob(File.join(output, "**", "*.{html,xml,txt,md}")).each do |path|
    check(!File.read(path).match?(/PRIVATE_DRAFT_SENTINEL|PRIVATE_ATTACHMENT_SENTINEL|FUTURE_POST_SENTINEL/), "Unpublished content leaked: #{path}")
  end
end
puts "Passed: publication, Markdown, escaping, existing URLs, feed, sitemap, assets, and draft/future exclusions."
