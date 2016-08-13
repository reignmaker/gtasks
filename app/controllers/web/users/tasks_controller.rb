module Web
  module Users
    class TasksController < ApplicationController
      respond_to :html, :js
      responders :flash
      before_action :require_login
      before_action :load_task, only: [:show, :edit, :update, :change_state, :destroy]

      def new
        @task = current_user.original_tasks.build
      end

      def create
        @task = current_user.tasks.create(task_params)
        respond_with @task, location: -> { users_task_path(@task) }
      end

      def update
        @task.update(task_params)
        respond_with @task, location: -> { users_task_path(@task) }
      end

      def change_state
        @task.fire_state_event(params[:state])
        respond_with @task
      end

      def destroy
        @task.destroy
        respond_with @task, location: -> { users_root_path }
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

      def interpolation_options
        { resource_name: @task.name }
      end

    end
  end
end