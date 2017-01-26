class TagsTicket < ApplicationRecord
  belongs_to :ticket, optional: true
  belongs_to :tag, optional: true
end
