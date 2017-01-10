class Project < ApplicationRecord
  validates_presence_of :name
  has_many :tickets, dependent: :delete_all
  has_many :roles, dependent: :delete_all
end
