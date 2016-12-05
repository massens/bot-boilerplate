class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.string :uid
      t.text :context
      t.integer :user_id

      t.timestamps
    end
  end
end
