class AddLinkToListings < ActiveRecord::Migration
  def change
    add_column :listings, :link, :string
  end
end
