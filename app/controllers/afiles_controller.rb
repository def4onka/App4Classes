class AfilesController < ApplicationController
  before_action :set_afile, only: [:show, :edit, :update, :destroy]

  # GET /afiles
  # GET /afiles.json
  def index
    @afiles = Afile.all
  end

  # GET /afiles/1
  # GET /afiles/1.json
  def show
  end

  # GET /afiles/new
  def new
    @afile = Afile.new
  end

  # GET /afiles/1/edit
  def edit
  end

  # POST /afiles
  # POST /afiles.json
  def create
    @afile = Afile.new(afile_params)

    respond_to do |format|
      if @afile.save
        format.html { redirect_to @afile, notice: 'Afile was successfully created.' }
        format.json { render :show, status: :created, location: @afile }
      else
        format.html { render :new }
        format.json { render json: @afile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /afiles/1
  # PATCH/PUT /afiles/1.json
  def update
    respond_to do |format|
      if @afile.update(afile_params)
        format.html { redirect_to @afile, notice: 'Afile was successfully updated.' }
        format.json { render :show, status: :ok, location: @afile }
      else
        format.html { render :edit }
        format.json { render json: @afile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /afiles/1
  # DELETE /afiles/1.json
  def destroy
    @afile.destroy
    respond_to do |format|
      format.html { redirect_to afiles_url, notice: 'Afile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_afile
      @afile = Afile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def afile_params
      params.require(:afile).permit(:document_id, :source, :path)
    end
end
