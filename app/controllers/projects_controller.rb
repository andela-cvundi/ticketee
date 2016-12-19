class ProjectsController < ApplicationController

  before_action :find_project, only: [:show, :edit, :update, :delete]

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      flash[:success] = "Project has been created"
      redirect_to @project
    else
      flash.now[:alert] = "Project has not been created."
      render "new"
    end
  end

  def show
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

  def destroy
    @project.destroy
    flash[:success] = "Project was deleted"
    redirect_to projects_path
  end


  private

  def find_project
    @project = Project.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    flash[:alert] = "The project you are looking for could not be found"
    redirect_to projects_path
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end

end
