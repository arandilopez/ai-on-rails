class DrugsController < ApplicationController
  def index
    @pagy, @drugs = pagy(Drug.order(id: :asc).all)
    respond_to do |format|
      format.html
      format.turbo_stream
    end
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
