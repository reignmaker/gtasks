module Web
  class WelcomeController < ApplicationController
    def index
      @tasks = Task.includes(:user)
    end
  end
end