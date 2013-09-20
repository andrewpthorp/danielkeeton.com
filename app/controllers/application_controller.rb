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
end
