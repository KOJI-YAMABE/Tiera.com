class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :image_id
      t.integer :garbage_count
      t.text :content
      t.integer :join_amount
      t.timestamps
    end
  end
end
