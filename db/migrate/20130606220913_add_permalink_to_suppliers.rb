class AddPermalinkToSuppliers < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_suppliers, :slug, :string
    add_index :spree_suppliers, :slug, unique: true
  end
end
