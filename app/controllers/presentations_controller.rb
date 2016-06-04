class PresentationsController < ApplicationController
  before_action :set_presentation, only: [:show, :edit, :update, :destroy]
  # layout "application", :exept => [:show]
  layout :resolve_layout, :only => [:show]

  # GET /presentations
  # GET /presentations.json
  def index
    @presentations = Presentation.all.order(:document_id)
  end

  # Content_types (аргумент может быть с точкой и без неё)
  #     Полезно добавить ещё некоторые типы?
  CONTENT_TYPE = {
    'svg'      => 'image/svg+xml',
    '.svg'     => 'image/svg+xml',
    'html'     => 'text/html',
    '.html'    => 'text/html',
    'png'      => 'image/png',
    '.png'     => 'image/png',
    'jpg'      => 'image/jpg',
    '.jpg'     => 'image/jpg',
    'pdf'      => 'application/pdf',
    '.pdf'     => 'application/pdf',
    'css'      => 'text/css',
    '.css'     => 'text/css',
    'js'      => 'text/javascript',
    '.js'     => 'text/javascript',
  }
  CONTENT_TYPE.default = 'application/octet-stream'

  def show
    @slide = params[:slide].to_i
    @section = @presentation.document.sections[@slide]
    @document = @presentation.document

    respond_to do |format|
      request.format = :html if request.format != :json
      format.json do
        @presentation.update_column(:last_open_slide, params[:value].to_i)
        render json: (params[:type] == 'hide' ? 'background' : 'none').to_json
      end
      format.html do
        if params[:show]=="show"
          # Собственно слайды
            if @current_user.prepod?
              if @presentation.auto_open
                @presentation.update_column(:last_open_slide, @slide)
              else
                if @slide > @presentation.last_open_slide
                  @background = 'gray'
                end
              end
            end
        else
          # Графические изображения или css-файлы
          puts("!!!!!!!!!!!!!!!!!!!!!!!1"+params[:format])
          if CONTENT_TYPE[params[:format]]
          d_id = @presentation.document_id
          # afile = (Afile.where(document_id: d_id, path: "#{params[:show]}.css")).first
          # send_data afile.source, disposition: 'inline', type: CONTENT_TYPE["css"]
          afile = (Afile.where(document_id: d_id, path: "#{params[:show]}.#{params[:format]}")).first
          # if afile.blank?
            # puts("!!!!!!!!!!!!!!!!!!!!!!!!!")
            # afile = (Afile.where(document_id: d_id, path: "#{params[:show].gsub(/\//,'_')}.#{params[:format]}")).first
          # end
          send_data afile.source, disposition: "inline", type: CONTENT_TYPE[params[:format]]
        end
        end
      end
    end
  end

  # GET /presentations/new
  def new
    @presentation = Presentation.new
  end

  # GET /presentations/1/edit
  def edit
  end

  # POST /presentations
  # POST /presentations.json
  def create
    @presentation =
      Presentation.new(document_id: params[:document_id],
                       comment: params[:presentation][:comment],
                       user_id: @current_user.id,
                       groups: params[:presentation][:groups_string].split.uniq,
                       last_open_slide: params[:presentation][:last_open_slide],
                       auto_open: params[:presentation][:auto_open] == '1')
    if @presentation.save
      redirect_to presentations_path
    else
      @presentation.groups_string =  params[:presentation][:groups_string]
      render 'edit'
    end
  end

  # PATCH/PUT /presentations/1
  # PATCH/PUT /presentations/1.json
  def update
    respond_to do |format|
      if @presentation.update(presentation_params)
        format.html { redirect_to presentations_path, notice: 'Presentation was successfully updated.' }
        format.json { render :index, status: :ok, location: @presentations }
      else
        format.html { render :edit }
        format.json { render json: @presentation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /presentations/1
  # DELETE /presentations/1.json
  def destroy
    @presentation.destroy
    respond_to do |format|
      format.html { redirect_to presentations_url, notice: 'Presentation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

  def resolve_layout
    case @presentation.document.way
    when 0
      "reveal"
    when 1
      "dz"
    end
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_presentation
      @presentation = Presentation.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def presentation_params
      params.require(:presentation).permit(:document_id, :user_id, :comment, :groups, :last_open_slide, :auto_open)
    end
end
