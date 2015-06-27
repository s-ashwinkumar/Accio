class AddDefaultValuesToUser < ActiveRecord::Migration
  def change
  	change_column :users, :active, :boolean, :default => false
  	change_column :users, :verified, :boolean, :default => false
  end
end
