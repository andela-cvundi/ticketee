class Comment < ApplicationRecord
  after_create :set_ticket_state

  belongs_to :user
  belongs_to :ticket
  belongs_to :state

  scope :persisted, lambda { where.not(id: nil) }

  delegate :project, to: :ticket

  validates :text, presence: true

  def set_ticket_state
    ticket.state = state
    ticket.save
  end

end
