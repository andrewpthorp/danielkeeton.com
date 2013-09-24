class AddLatitudeAndLongitudeToListings < ActiveRecord::Migration
  def change
    add_column :listings, :latitude, :float
    add_column :listings, :longitude, :float

    Listing.reset_column_information
    Listing.all.each do |listing|
      listing.geocode
      listing.save
    end
  end
end
