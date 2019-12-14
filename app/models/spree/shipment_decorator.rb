module Spree::ShipmentDecorator
  # TODO here to fix cancan issue thinking its just Order

  def self.prepended(base)
    base.belongs_to :order, class_name: Spree::Order.to_s, touch: true, inverse_of: :shipments

    base.has_many :payments, as: :payable

    base.scope :by_supplier, -> (supplier_id) { joins(:stock_location).where(spree_stock_locations: { supplier_id: supplier_id }) }

    base.delegate :supplier, to: :stock_location

    base.durably_decorate :after_ship, mode: 'soft', sha: 'e8eca7f8a50ad871f5753faae938d4d01c01593d' do
      original_after_ship

      if supplier.present?
        update_commission
      end
    end

    base.whitelisted_ransackable_attributes = ['number', 'state']
  end

  def display_final_price_with_items
    Spree::Money.new final_price_with_items
  end

  def final_price_with_items
    self.item_cost + self.final_price
  end

  # TODO move commission to spree_marketplace?
  def supplier_commission_total
    ((self.final_price_with_items * self.supplier.commission_percentage / 100) + self.supplier.commission_flat_rate)
  end

  private

  def update_commission
    update_column :supplier_commission, self.supplier_commission_total
  end

end

Spree::Shipment.prepend Spree::ShipmentDecorator
