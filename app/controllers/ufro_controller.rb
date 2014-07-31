class UfroController < ApplicationController
  before_action :set_page
  layout false, :only => [:show]

  def index
    @works = current_user.works.order('created_at desc')
  end

  def show
    @work = current_user.works.find(params[:id])
  end

  private

  def set_page
    @page = "ufro"
  end
end
