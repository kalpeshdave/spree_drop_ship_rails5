class AddSupplierIdToCkeditorAssets < ActiveRecord::Migration[5.1]
  if table_exists?(:ckeditor_assets)
    def change
      add_column :ckeditor_assets, :supplier_id, :integer
      add_index  :ckeditor_assets, :supplier_id
    end
  end
end
