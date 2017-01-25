class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true
  belongs_to :state

  has_many :attachments, dependent: :destroy
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :attachments, reject_if: :all_blank

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }


end
