class AddInboxIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :inbox_id, :integer
  end
end
