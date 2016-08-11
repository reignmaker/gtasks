class Task < ActiveRecord::Base
  include AASM
  enum state: [:created, :started, :finished]
  belongs_to :user
  validates :name, presence: true

  aasm column: :state do
    event :start do
      transitions from: :created, to: :started
    end

    event :finish do
      transitions from: :started, to: :finished
    end
  end


end
