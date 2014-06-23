class IndexController < ApplicationController
  before_action :authenticate_user!
  before_action :set_page

  def index
  end

  private

  def set_page
    @page = "index"
  end
end
