# frozen_string_literal: true

class ProjectsController < ApplicationController
  def index
    @projects = current_user.projects
  end

  def new
    @project = ProjectForm.new(Project.new)
  end

  def create
    @project = ProjectForm.new(current_user.projects.new)
    @project.validate(project_params) ? @project.save : render(:new)
  end

  def edit
    @project = current_user.projects.find_by(id: params[:id])
  end

  def update
    @project = ProjectForm.new(current_user.projects.find_by(id: params[:id]))
    @project.validate(project_params) ? @project.save : render(:edit)
  end

  def destroy
    @project = current_user.projects.find_by(id: params[:id])
    @project.destroy
  end

  private

  def project_params
    params.require(:project).permit(:name)
  end
end
