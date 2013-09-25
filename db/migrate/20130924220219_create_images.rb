class CreateImages < ActiveRecord::Migration
  def up
    create_table :images do |t|
      t.string :file
      t.boolean :primary, default: false
      t.references :listing, index: true
      t.timestamps
    end

    add_index :images, :primary
    remove_column :listings, :image
  end

  def down
    remove_index :images, :primary
    drop_table :images
    add_column :listings, :image, :string
  end
end
