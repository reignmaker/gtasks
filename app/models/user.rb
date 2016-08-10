class User < ActiveRecord::Base
  include Clearance::User
  enum role: [:user, :admin]
  has_many :tasks, dependent: :destroy
end
