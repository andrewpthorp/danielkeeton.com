class ApplicationController < ActionController::Base
  protect_from_forgery

  # Internal: Call :set_current_section before every action.
  before_filter :set_current_section

  # Internal: Set @section to the current controller name.
  #
  # Returns nothing.
  def set_current_section
    @section = params[:controller]
  end

  # Internal: Render an HTTP 404.
  #
  # Returns nothing.
  def render_404
    render file: 'public/404', layout: false, formats: [:html], status: 404
  end
end
