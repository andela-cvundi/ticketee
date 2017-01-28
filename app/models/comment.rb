class Comment < ApplicationRecord

  before_create :set_previous_state
  after_create :set_ticket_state

  belongs_to :user
  belongs_to :ticket
  belongs_to :state
  belongs_to :previous_state, class_name: "State"


  scope :persisted, lambda { where.not(id: nil) }

  delegate :project, to: :ticket

  validates :text, presence: true

  after_create :author_watches_ticket

  def set_ticket_state
    ticket.state = state
    ticket.save
  end

  def set_previous_state
    self.previous_state = ticket.state
  end

  def author_watches_ticket
    if user.present? && !ticket.watchers.include?(user)
      ticket.watchers << user
    end
  end

end
