class DrugsController < ApplicationController
  def index
    @pagy, @drugs = pagy(Drug.order(id: :asc).select(:id, :slug, :name))
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def show
    @drug = Drug.find_by(slug: params[:slug])
  end

  def ask
    @drugs = Drug.search(params[:query])
    ai = DrugAi.new
    @response = ai.ask(params[:query], @drugs.first(2))

    respond_to do |format|
      format.html { render :index }
      format.turbo_stream
    end
  end

  def summarize
  end
end
