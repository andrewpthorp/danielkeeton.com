module ApplicationHelper

  # Public: Get the navigation for each region we want to build the site to
  # handle. Each region will just merge the correct region into whatever the
  # current set of params are. This will essentially just reload the current
  # page and store the region in the session.
  #
  # Returns an ActiveSupport::SafeBuffer.
  def regions_nav
    curr = session[:region] || 'all'

    items = [
      content_tag(:dd, link_to('All Regions', params.merge(region: 'all')), class: curr == 'all' ? 'active' : ''),
      content_tag(:dd, link_to('Richmond', params.merge(region: 'richmond')), class: curr == 'richmond' ? 'active' : ''),
      content_tag(:dd, link_to('Goochland', params.merge(region: 'goochland')), class: curr == 'goochland' ? 'active' : ''),
    ]

    content_tag :dl, class: 'sub-nav regions' do
      items.map do |item|
        concat(item)
      end
    end
  end

end
