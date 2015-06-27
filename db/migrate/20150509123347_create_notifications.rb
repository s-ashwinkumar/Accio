class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :service_id
      t.string :requestor_name
      t.string :requestor_phone
      t.text :requestor_message
      t.string :group_id
      t.boolean :active, :default =>  true
      t.timestamps
    end
  end
end
