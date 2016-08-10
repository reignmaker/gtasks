class TasksController < ApplicationController
  before_action :require_login, only: [:new, :edit, :update, :destroy]
  def index
    @tasks = Task.includes(:user)
  end
end
