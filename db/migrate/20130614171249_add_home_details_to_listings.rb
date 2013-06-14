class AddHomeDetailsToListings < ActiveRecord::Migration
  def change
    change_table :listings do |t|
      t.integer :bedrooms
      t.float :bathrooms
      t.integer :square_footage
      t.integer :lot_size
      t.integer :year_built
    end
  end
end
