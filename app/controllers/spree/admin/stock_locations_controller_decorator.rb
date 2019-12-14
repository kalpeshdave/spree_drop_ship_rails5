module Spree::Admin::StockLocationsControllerDecorator

  def self.prepended(base)
    base.after_action :set_supplier, only: [:create]
  end

  private

  def set_supplier
    if try_spree_current_user.supplier?
      @object.supplier = try_spree_current_user.supplier
      @object.save
    end
  end

end

Spree::Admin::StockLocationsController.prepend Spree::Admin::StockLocationsControllerDecorator
