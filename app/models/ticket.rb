class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true
  belongs_to :state
  has_many :tags_tickets, dependent: :destroy
  has_many :tags, through: :tags_tickets

  has_many :attachments, dependent: :destroy
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :attachments, reject_if: :all_blank
  attr_accessor :tag_names

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  def tag_names=(names)
    @tag_names = names
    names.split.each do |name|
      self.tags << Tag.find_or_initialize_by(name: name)
    end
  end


end
