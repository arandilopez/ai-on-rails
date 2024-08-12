module DrugsHelper
  def render_markdown(text)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true,)
    markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
    markdown.render(text).html_safe
  end
end
