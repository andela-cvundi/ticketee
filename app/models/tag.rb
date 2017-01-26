class Tag < ApplicationRecord

  has_many :tags_tickets, dependent: :destroy
  has_many :tickets, through: :tags_tickets

end
