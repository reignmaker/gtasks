class User < ActiveRecord::Base
  include Clearance::User
  enum role: [:user, :admin]
end
