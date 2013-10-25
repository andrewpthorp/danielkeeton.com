# Public: All helpers that are to be used for DynamicContents are in here. Even
# though all helpers are application-wide, it makes sense to put them here for
# clarity.
module DynamicContentsHelper

  # Public: Get the caption for a slider (or image) for a DynamicContent. If the
  # DynamicContent has a :mobile_content that is not blank, use that. If the
  # DynamicContent does not have a :mobile_content, use a truncated form of the
  # :content.
  #
  # content - The DynamicContent to use for the caption.
  #
  # Returns an ActiveSupport::SafeBuffer.
  def slider_caption(content)
    elems = [
      { t: content.content, class: 'hide-for-small show-for-medium-up' },
      {
        t: content.mobile_content.blank? ?
          truncate(content.content, length: 40) : content.mobile_content,
        class: 'show-for-small hide-for-medium-up'
      }
    ]

    content_tag(:div, class: 'orbit-caption') do
      elems.reduce('') do |div, elem|
        div << content_tag(:div, elem[:t], class: elem[:class])
      end.html_safe
    end
  end

end
