# Public: All helpers that are to be used for Regions are in here. Even though
# all helpers are application-wide, it makes sense to put them here for clarity.
module RegionsHelper

  # Public: Get the navigation for each region we want to build the site to
  # handle. Each region will just merge the correct region into whatever the
  # current set of params are. This will essentially just reload the current
  # page and store the region in the session.
  #
  # Returns an ActiveSupport::SafeBuffer.
  def regions_nav
    curr = session[:region] || 'all'

    items = [
      content_tag(:dd, link_to('All Regions', root_url(subdomain: 'www')), class: curr == 'all' ? 'active' : '')
    ]

    # Include all linkable Regions.
    Region.linkable.each do |region|
      items << content_tag(:dd, link_to(region.name, root_url(subdomain: region.slug)), class: curr == region.slug ? 'active' : '')
    end

    content_tag :dl, class: 'sub-nav regions' do
      items.map do |item|
        concat(item)
      end
    end
  end

end
