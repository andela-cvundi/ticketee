class CreateTagsTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tags_tickets do |t|
      t.references :ticket, foreign_key: true
      t.references :tag, foreign_key: true
      t.index [:tag_id, :ticket_id]
      t.index [:ticket_id, :tag_id]
    end
  end
end
