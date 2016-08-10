class TasksController < ApplicationController
  before_action :require_login, only: [:new, :edit, :update, :destroy]
  before_action :load_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = Task.includes(:user)
  end

  def show

  end

  protected

  def load_task
    @task = Task.includes(:user).find(params[:id])
  end

end
