class CreateTweets < ActiveRecord::Migration[5.0]
  def up
    create_table :tweets do |t|
      t.string :message
      t.belongs_to :user
      t.timestamps
    end
  end
  def down
    drop_table :tweets
  end
end
