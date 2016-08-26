Clearance.configure do |config|
  config.mailer_sender = "reply@example.com"
  config.application_controller = Web::ApplicationController
  config.redirect_url = :users_root
end
