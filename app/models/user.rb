class User < ActiveRecord::Base
  include Clearance::User
  enum role: [:user, :admin]
  has_many :tasks, dependent: :destroy

  def to_s
    try(:email)
  end

end
