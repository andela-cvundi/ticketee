class ProjectsController < ApplicationController

  before_action :find_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
    @tickets = @project.tickets
  end

  def edit
    @project = Project.find(params[:id])
  end


  def update
    if @project.update(project_params)
      flash[:success] = "Project was updated successfully"
      redirect_to @project
    else
      flash.now[:danger] = "Error updating the project"
      render :edit
    end
  end


  private

  def find_project
    @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    flash[:danger] = "The project you are looking for could not be found"
    redirect_to projects_path
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end

end
