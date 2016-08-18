module Web
  module Users
    class WelcomeController < Users::ApplicationController
      def index
        @tasks = current_user.tasks.order(:created_at)
      end
    end
  end
end