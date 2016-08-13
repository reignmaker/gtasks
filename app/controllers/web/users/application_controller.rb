module Web
  module Users
    class ApplicationController < ::Web::ApplicationController
      before_action :require_login
    end
  end
end

