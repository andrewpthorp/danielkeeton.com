ActiveAdmin.register Listing do
  index do
    column :id
    column :title
    column "Price" do |listing|
      number_to_currency(listing.price)
    end
    column "Thumbnail" do |listing|
      image_tag listing.image.thumb
    end
    actions
  end

  form do |f|
    f.inputs "General Information" do
      f.input :title
      f.input :description
      f.input :price
      f.input :status, as: :select, collection: Listing::VALID_STATES, include_blank: false
      f.input :featured
      f.input :image
    end
  end
end
