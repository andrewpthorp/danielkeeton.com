class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.string :title
      t.text :description
      t.string :status
      t.integer :price
      t.boolean :featured
      t.timestamps
    end
  end
end
