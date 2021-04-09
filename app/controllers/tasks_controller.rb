# frozen_string_literal: true

class TasksController < ApplicationController
  def new
    @task = TaskForm.new(Task.new)
  end

  def create
    @task = TaskForm.new(current_user.projects.find_by(id: params[:project_id]).tasks.new)
    @task.save if @task.validate(task_params)
  end

  def reprioritate
    @task = current_user.tasks.find_by(id: params[:task_id])
    params[:up] == '1' ? @task.move_higher : @task.move_lower
    @tasks = @task.project.tasks
    render :index
  end

  def complete
    task = current_user.tasks.find_by(id: params[:task_id])
    task.update(completed: !task.completed)
    render status: :ok
  end

  def edit
    @task = current_user.tasks.find_by(id: params[:id])
  end

  def update
    @task = TaskForm.new(current_user.tasks.find_by(id: params[:id]))
    @task.validate(task_params) ? @task.save : render(:edit)
  end

  def destroy
    @task = current_user.tasks.find_by(id: params[:id])
    @task.destroy
  end

  private

  def task_params
    params.require(:task).permit(:text, :deadline)
  end
end
