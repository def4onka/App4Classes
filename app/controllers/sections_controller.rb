class SectionsController < ApplicationController
  before_action :set_presentation, only: [:show]

  # GET /sections
  # GET /sections.json
  def index
    @sections = Section.all
  end

  # GET /sections/1
  # GET /sections/1.json
  def show
    @slide = params[:slide].to_i
    @section = @presentation.document.sections[@slide]
    @sections = @presentation.document.sections
    puts(@sections.size)

    respond_to do |format|
      request.format = :html if request.format != :json
      format.json do
        @presentation.update_column(:last_open_slide, params[:value].to_i)
        render json: (params[:type] == 'hide' ? 'background' : 'none').to_json
      end
      format.html do
        if params[:name].nil?
          # Собственно слайды
            if @current_user.prepod?
              if @presentation.auto_open
                @presentation.update_column(:last_open_slide, @slide)
              else
                if @slide > @presentation.last_open_slide
                  @background = 'gray'
                end
              end
          render :layout => 'dz'
        end


        else
          # Графические изображения или css-файлы
          d_id = @presentation.document_id
          afile = (Afile.where(document_id: d_id, path: "files_#{params[:type]}_#{params[:name]}.#{params[:format]}")).first
          send_data afile.source, disposition: "inline", type: CONTENT_TYPE[params[:format]]
        end
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_presentation
      @presentation = Presentation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def section_params
      params.require(:section).permit(:document_id, :source, :position)
    end
end
