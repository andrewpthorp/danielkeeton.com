class SellingController < ApplicationController

  def index
    @page = Page.find('selling')
  end

end
