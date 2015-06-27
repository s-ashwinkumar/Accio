class CreateConversationMappings < ActiveRecord::Migration
  def change
    create_table :conversation_mappings do |t|
      t.integer :person1
      t.integer :person2
      t.string :conversation_id

      t.timestamps
    end
  end
end
