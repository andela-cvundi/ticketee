class Ticket < ApplicationRecord
  belongs_to :project
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 30 }
end
