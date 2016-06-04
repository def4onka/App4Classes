class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]
  #attr_accessor :file

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # GET /documents/1/edit
  def edit
  end

  def create
    respond_to do |format|
      format.html do
        d = Document.new(user_id: @current_user.id.to_i,
                        comment: params[:comment],
                         material_id: params[:material_id],
                         way: params[:document][:way])
        puts("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"+params[:comment].to_s)
        tmp = params[:document][:file].tempfile

        d.create_sections_and_afiles(tmp.path)
        tmp.close
        if d.save!
          p = Presentation.new(document_id: d.id, user_id: d.user_id,
                               comment: d.comment, groups: [],
                               last_open_slide: 0, auto_open: true)
          p.save(validate: false)
          redirect_to documents_path
        else
          render json: {error: d.errors.inspect}
        end
      end
    end
  end




  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to @document, notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to documents_url, notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def document_params
    #   params.require(:document).permit(:comment, :material_id)
    # end
end
