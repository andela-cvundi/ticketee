class TicketSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :project_id, :created_at,
    :updated_at, :user_id

  belongs_to :state
end
