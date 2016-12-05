class AddActiveToConversations < ActiveRecord::Migration[5.0]
  def change
    add_column :conversations, :active, :string
  end
end
