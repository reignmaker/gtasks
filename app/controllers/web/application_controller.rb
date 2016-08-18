module Web
  class ApplicationController < ::ApplicationController
    include ::Clearance::Controller
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

    rescue_from ActiveRecord::RecordNotFound do |e|
      render file: "public/404.html", layout: false, status: 404
    end

  end
end

