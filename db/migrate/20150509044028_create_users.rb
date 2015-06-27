class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone
      t.string :mobile
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :latitude
      t.string :longitude
      t.boolean :verified
      t.boolean :active

      t.timestamps
    end
  end
end
