class CreateTweetRequests < ActiveRecord::Migration
  def change
    create_table :tweet_requests do |t|
      t.string :service
      t.string :zipcode

      t.timestamps
    end
  end
end
