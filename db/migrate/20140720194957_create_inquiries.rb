class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :comments
      t.string :address
      t.string :square_footage
      t.string :bathrooms
      t.string :bedrooms
      t.text :updates
      t.string :inquiry_type

      t.timestamps
    end
  end
end
