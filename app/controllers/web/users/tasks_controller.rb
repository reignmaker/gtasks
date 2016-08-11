module Web
  module Users
    class TasksController < ApplicationController
      before_action :require_login, only: [:new, :edit, :update, :destroy]
      def index
        @tasks = current_user.tasks
      end
    end
  end
end