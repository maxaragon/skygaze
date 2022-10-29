class WeathericonsController < ApplicationController
  before_action :set_weathericon, only: %i[ show edit update destroy ]

  # GET /weathericons or /weathericons.json
  def index
    @weathericons = Weathericon.all
  end

  # GET /weathericons/1 or /weathericons/1.json
  def show
  end

  # GET /weathericons/new
  def new
    @weathericon = Weathericon.new
  end

  # GET /weathericons/1/edit
  def edit
  end

  # POST /weathericons or /weathericons.json
  def create
    @weathericon = Weathericon.new(weathericon_params)

    respond_to do |format|
      if @weathericon.save
        format.html { redirect_to weathericons_url, notice: "Weathericon was successfully created." }
        format.json { render :show, status: :created, location: @weathericon }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @weathericon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weathericons/1 or /weathericons/1.json
  def update
    respond_to do |format|
      if @weathericon.update(weathericon_params)
        format.html { redirect_to weathericons_url, notice: "Weathericon was successfully updated." }
        format.json { render :show, status: :ok, location: @weathericon }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @weathericon.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weathericons/1 or /weathericons/1.json
  def destroy
    @weathericon.destroy

    respond_to do |format|
      format.html { redirect_to weathericons_url, notice: "Weathericon was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weathericon
      @weathericon = Weathericon.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def weathericon_params
      params.require(:weathericon).permit(:name, :icon)
    end
end
