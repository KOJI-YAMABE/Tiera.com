class CreateSpots < ActiveRecord::Migration[5.2]
  def change
    create_table :spots do |t|
      t.integer :post_id
      t.string :address
      t.float :latitude
      t.float :longitude
      t.references :review
      t.index ["post_id"], name: "index_spots_on_post_id"
      t.timestamps
    end
  end
end
