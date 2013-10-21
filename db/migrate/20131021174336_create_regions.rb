class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.string :slug, index: true
      t.integer :idx_value
      t.boolean :linkable, index: true
      t.timestamps
    end
  end
end
