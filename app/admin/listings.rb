ActiveAdmin.register Listing do
  index do
    column :id
    column "Title", sortable: :title do |listing|
      truncate(listing.title, length: 15)
    end
    column "Price", sortable: :price do |listing|
      number_to_currency(listing.price, precision: 0)
    end
    column "Thumbnail" do |listing|
      unless listing.image.blank?
        image_tag listing.image.thumb
      end
    end
    column :link
    column "Status", sortable: :status do |listing|
      listing.status.titleize
    end
    column :featured, sortable: true
    actions
  end

  form do |f|
    f.inputs "General Information" do
      f.input :title
      f.input :description
      f.input :price
      f.input :link, label: "Link to MLS"
      f.input :status, as: :select, collection: Listing::VALID_STATES, include_blank: false
      f.input :featured
      f.input :image
    end

    f.inputs "Address" do
      f.input :address_line_1
      f.input :address_line_2
      f.input :city
      f.input :state
      f.input :zip
    end

    f.inputs "Home Information" do
      f.input :bedrooms, as: :select, collection: (1..10).to_a
      f.input :bathrooms, as: :select, collection: (0.5..5).step(0.5).to_a
      f.input :year_built, as: :select, collection: (1900..2013).to_a
      f.input :square_footage
      f.input :lot_size
    end

    f.actions
  end
end
