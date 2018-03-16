class ProductBelongsToSupplier < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_products, :supplier_id, :integer
    add_index :spree_products, :supplier_id
  end
end
