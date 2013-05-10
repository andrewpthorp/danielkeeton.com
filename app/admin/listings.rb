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
      image_tag listing.image.thumb
    end
    column :link
    column "Status", sortable: :status do |listing|
      pretty_status(listing)
    end
    column :featured, sortable: true
    actions
  end

  form do |f|
    f.inputs "General Information" do
      f.input :title
      f.input :description
      f.input :price
      f.input :link
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
    f.actions
  end
end
