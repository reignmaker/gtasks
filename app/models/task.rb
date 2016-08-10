class Task < ActiveRecord::Base
  enum state: [:created, :started, :finished]
  belongs_to :user
  validates :name, presence: true
end
