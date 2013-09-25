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
      unless listing.primary_image.blank?
        image_tag listing.primary_image.file.thumb
      end
    end
    column :link
    column "Status", sortable: :status do |listing|
      listing.status.titleize
    end
    column :featured, sortable: true
    actions
  end

  form partial: 'form'
end
