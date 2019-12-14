module Spree::StockLocationDecorator

  def self.prepended(base)
    base.belongs_to :supplier, class_name: Spree::Supplier.to_s

    base.scope :by_supplier, -> (supplier_id) { where(supplier_id: supplier_id) }
  end

  def available?(variant)
    stock_item(variant).try(:available?)
  end

  # Wrapper for creating a new stock item respecting the backorderable config and supplier
  def propagate_variant(variant)
    if self.supplier_id.blank? || variant.suppliers.pluck(:id).include?(self.supplier_id)
      self.stock_items.create!(variant: variant, backorderable: self.backorderable_default)
    end
  end
end

Spree::StockLocation.prepend Spree::StockLocationDecorator
