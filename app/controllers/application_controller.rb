class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Internal: Call :set_current_section before every action.
  before_filter :set_current_section

  # Internal: Call :set_current_region before every action.
  before_filter :set_current_region

  # Internal: Set @section to the current controller name.
  #
  # Returns nothing.
  def set_current_section
    @section = params[:controller]

    if @section == 'page'
      @section += '-' + params[:id]
  end

  # Internal: Set region in the session to what is in the params hash. If the
  # region in the params hash is all, we clear the region from the session. If
  # there is no region in the params hash, we do not modify the region in the
  # session.
  #
  # Returns nothing.
  def set_current_region
    return if session[:region] == request.subdomain

    if !request.subdomain.blank? && request.subdomain != 'www'
      region = Region.where(slug: request.subdomain).first
      if region && region.linkable?
        session[:region] = request.subdomain
      else
        session.delete(:region)
      end
    else
      session.delete(:region)
    end
  end

  # Internal: Render an HTTP 404.
  #
  # Returns nothing.
  def render_404
    render file: 'public/404', layout: false, formats: [:html], status: 404
  end
end
