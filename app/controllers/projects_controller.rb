class ProjectsController < ApplicationController

  before_action :find_project, only: [:show, :edit, :update, :destroy]

  def index
    @projects = policy_scope(Project)
  end

  def show
    authorize @project, :show?
    @tickets = @project.tickets
  end

  def edit
    authorize @project, :update?
  end


  def update
    authorize @project, :update?
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
