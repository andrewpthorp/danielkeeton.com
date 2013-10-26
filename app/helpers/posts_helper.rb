# Public: All helpers that are to be used for Posts are in here. Even though
# all helpers are application-wide, it makes sense to put them here for clarity.
module PostsHelper

  # Public: Render given String to markdown formatted HTML.
  #
  # text - The String to render as markdown.
  #
  # Returns an ActiveSupport::SafeBuffer.
  def markdown(text)
    opts = { autolink: true, space_after_headers: true }
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, opts)
      .render(text).html_safe
  end

  # Public: Get the status tag to use for a Post.
  #
  # post - The Post to render a status tag for.
  #
  # Returns an ActiveSupport::SafeBuffer.
  def post_status_tag(post)
    if post.published?
      content_tag(:small, 'PUBLISHED', class: 'tag green')
    else
      content_tag(:small, 'DRAFT', class: 'tag light-blue')
    end
  end

end
