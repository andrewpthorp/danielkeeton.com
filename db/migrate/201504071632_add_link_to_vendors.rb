class AddLinkToVendors < ActiveRecord::Migration
  def change
    add_column :vendors, :link, :string
  end
end
