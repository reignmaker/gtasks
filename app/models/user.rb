class User < ActiveRecord::Base
  include Clearance::User
  enum role: [:user, :admin]
  has_many :tasks, dependent: :destroy

  alias_method :original_tasks, :tasks

  def to_s
    try(:email)
  end

  def tasks
    return @tasks ||= Task.includes(:user) if admin?
    original_tasks
  end

end
