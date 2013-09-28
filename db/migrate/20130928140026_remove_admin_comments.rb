class RemoveAdminComments < ActiveRecord::Migration
  def up
    remove_index :active_admin_comments, name: 'index_admin_notes_on_resource_type_and_resource_id'
    remove_index :active_admin_comments, [:namespace]
    remove_index :active_admin_comments, [:author_type, :author_id]
    drop_table :active_admin_comments
  end

  def down
    create_table :active_admin_comments do |t|
      t.string :resource_id, null: false
      t.string :resource_type, null: false
      t.integer :author_id
      t.string :author_type
      t.string :namespace
      t.text :body
      t.timestamps
    end

    add_index :active_admin_comments, [:resource_type, :resource_id], name: 'index_admin_notes_on_resource_type_and_resource_id'
    add_index :active_admin_comments, [:namespace]
    add_index :active_admin_comments, [:author_type, :author_id]
  end
end
