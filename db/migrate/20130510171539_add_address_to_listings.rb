class AddAddressToListings < ActiveRecord::Migration
  def change
    add_column :listings, :address_line_1, :string
    add_column :listings, :address_line_2, :string
    add_column :listings, :city, :string
    add_column :listings, :state, :string
    add_column :listings, :zip, :string
  end
end
