class AddTitleAndMobileContentToDynamicContents < ActiveRecord::Migration
  def change
    add_column :dynamic_contents, :title, :string
    add_column :dynamic_contents, :mobile_content, :text
  end
end
