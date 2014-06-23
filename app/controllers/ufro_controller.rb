class UfroController < ApplicationController
  before_action :set_page

  def index
  end

  private

  def set_page
    @page = "ufro"
  end
end
