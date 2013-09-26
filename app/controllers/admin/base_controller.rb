class Admin::BaseController < ::ApplicationController
  # Internal: Use the 'admin' layout.
  layout 'admin'

  # Internal: All actions that are performed in an admin controller require that
  # an Admin is logged in.
  before_filter :authenticate_admin!

  # Internal: Overrides ApplicationController#set_current_section for Admin::
  # controllers.
  #
  # Returns nothing.
  def set_current_section
    @section = params[:controller].gsub(/.*\//, '')
  end
end
