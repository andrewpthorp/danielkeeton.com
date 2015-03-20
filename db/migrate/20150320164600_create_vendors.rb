class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :label
      t.string :image

      t.timestamps
    end
  end
end
