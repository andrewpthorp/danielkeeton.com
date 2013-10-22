class CreateDynamicContents < ActiveRecord::Migration
  def change
    create_table :dynamic_contents do |t|
      t.string :subject
      t.text :content
      t.references :region, index: true
      t.timestamps
    end
  end
end
