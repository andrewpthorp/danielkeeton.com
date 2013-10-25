class AddImageToDynamicContents < ActiveRecord::Migration
  def change
    add_column :dynamic_contents, :image, :string
  end
end
