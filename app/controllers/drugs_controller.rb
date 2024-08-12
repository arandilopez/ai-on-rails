class DrugsController < ApplicationController
  def index
    @pagy, @drugs = pagy(Drug.order(id: :asc).all)
  end

  def show
    @drug = Drug.find_by(slug: params[:slug])
  end

  def search
    @pagy, @drugs = pagy(Drug.search(params[:query]))
  end

  def summarize
  end
end
