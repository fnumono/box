class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :edit, :update, :destroy]

  # GET /folders
  # GET /folders.json
  def index
    @folders = current_user.folders
  end

  # GET /folders/1
  # GET /folders/1.json
  def show
    @folder = current_user.folders.find(params[:id])
  end

  # GET /folders/newr
  def new
    @folder = current_user.folders.new

    if params[:folder_id]
      @current_folder = current_user.folders.find(params[:folder_id])
      @folder.parent_id = @current_folder.id
    end

  end

  # GET /folders/1/edit
  def edit
    @folder = current_user.folders.find(params[:folder_id])
    @current_folder = @folder.parent
  end

  # POST /folders
  # POST /folders.json
  def create
    @folder = current_user.folders.new(folder_params)

    if @folder.save 
      flash[:notice] = "Successfully created folder"

      if @folder.parent
        redirect_to browse_path(@folder.parent)
      else
        redirect_to root_url
      end
    else
      render :action => 'new'
    end
    
  end

  # PATCH/PUT /folders/1
  # PATCH/PUT /folders/1.json
  def update
    @folder = current_user.folders.find(params[:id])
    
      if @folder.update(folder_params)
        if @folder.parent
          redirect_to browse_path(@folder.parent)
        else
          redirect_to root_url
        end
        # format.html { redirect_to root_url, notice: 'Folder was successfully updated.' }
        # format.json { render :shows: :ok, location: @folder }
      end
  end

  # DELETE /folders/1
  # DELETE /folders/1.json
  def destroy
    @folder = current_user.folders.find(params[:id])
    @parent_folder = @folder.parent
    @folder.destroy

    flash[:notice]="Successfully deleted the folder and all the content."

    if @parent_folder
      redirect_to browse_path(@parent_folder)
    else
      redirect_to root_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      if params[:folder_id]
        @folder = current_user.folders.find(params[:folder_id])
      else
        @folder = current_user.folders.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def folder_params
      params.require(:folder).permit(:name, :parent_id, :user_id)
    end
end
