class CurationsController < ApplicationController
  before_action :set_curation, only: [:show, :edit, :update]

  # GET /curations
  def index
    @curation = Curation.all
  end

  # GET /curations/1
  def show
  end

  # GET /curations/new
  def new
    @curation = Curation.new
  end

  # GET /curations/1/edit
  def edit
  end

  # POST /curations
  def create
    @curation = Curation.new(curation_params)

    if @curation.save
      redirect_to @curation, notice: 'Curation was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /curations/1
  def update
    if @curation.update(curation_params)
      redirect_to @curation, notice: 'Curation was successfully updated.'
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_curation
    @curation = Curation.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def curation_params
    params.require(:curation).permit(:title, :description)
  end

end
