class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :ticket

  scope :persisted, lambda { where.not(id: nil) }

  delegate :project, to: :ticket

  validates :text, presence: true
end
