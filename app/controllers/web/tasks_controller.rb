module Web
  class TasksController < ApplicationController
    before_action :require_login
    before_action :load_task, only: [:show, :edit, :update, :destroy]

    def index
      @tasks = Task.includes(:user)
    end

    def new
      @task = current_user.original_tasks.build
    end

    def update
      if @task.update(task_params)
        flash[:notice] = "Successfuly updated Task ##{@task.id}"
        redirect_to @task
      else
        flash[:danger] = @task.errors.full_messages.join(' ')
        render :edit
      end
    end

    def destroy
      if @task.destroy
        flash[:notice] = "Successfuly deleted Task ##{@task.id}"
      end
      redirect_to user_tasks_path
    end

    protected

    def load_task
      @task = current_user.tasks.find(params[:id])
    end

    def task_params
      tsk_params = [:name, :description, :state]
      tsk_params << :user_id if current_user.admin?
      params.fetch(:task).permit(tsk_params)
    end

  end
end