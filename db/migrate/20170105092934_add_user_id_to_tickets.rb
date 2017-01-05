class AddUserIdToTickets < ActiveRecord::Migration[5.0]
  def change
    add_reference :tickets, :user, foreign_key: true, index: true
  end
end
