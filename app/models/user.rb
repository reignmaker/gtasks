class User < ActiveRecord::Base
  include Clearance::User
  enum roles: [:user, :admin]
end
