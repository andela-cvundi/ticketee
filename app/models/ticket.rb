class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :user, optional: true
  belongs_to :state

  has_many :tags_tickets, dependent: :destroy
  has_many :tags, through: :tags_tickets

  has_many :attachments, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_and_belongs_to_many :watchers, join_table: "ticket_watchers",
    class_name: "User", uniq: true

  accepts_nested_attributes_for :attachments, reject_if: :all_blank
  attr_accessor :tag_names

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  after_create :author_watches_me

  def tag_names=(names)
    @tag_names = names
    names.split.each do |name|
      self.tags << Tag.find_or_create_by(name: name)
    end
  end

  def author_watches_me
    if user.present? && !self.watchers.include?(user)
      self.watchers << user
    end
  end


end
