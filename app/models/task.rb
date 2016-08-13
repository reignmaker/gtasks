class Task < ActiveRecord::Base
  belongs_to :user
  has_one :attachment, as: :attachable, depended: :destroy
  validates :name, presence: true

  state_machine :state, initial: :new do

    state :new, value: 0
    state :started, value: 1
    state :finished, value: 2

    event :start do
      transition new: :started
    end

    event :finish do
      transition [:new, :started] => :finished
    end

    event :reopen do
      transition [:started, :finished] => :new
    end

  end

  def self.events
    state_machines[:state].events.map(&:name)
  end

  def self.states
    [:new, :started, :finished]
  end

end
