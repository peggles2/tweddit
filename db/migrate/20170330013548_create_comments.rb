class CreateComments < ActiveRecord::Migration[5.0]
  def up
    create_table :comments do |t|
      t.string :message
      t.belongs_to :user
      t.belongs_to :tweet
      t.timestamps
    end
  end
  def down 
    drop_table :comments
  end
end
