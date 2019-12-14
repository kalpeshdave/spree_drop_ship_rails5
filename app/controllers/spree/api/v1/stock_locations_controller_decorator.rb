module Spree::Api::V1::StockLocationsControllerDecorator

  def self.prepended(base)
    base.before_action :supplier_locations, only: [:index]
    base.before_action :supplier_transfers, only: [:index]
  end

  private

  def supplier_locations
    params[:q] ||= {}
    params[:q][:supplier_id_eq] = spree_current_user.supplier_id
  end

  def supplier_transfers
    params[:q] ||= {}
    params[:q][:supplier_id_eq] = spree_current_user.supplier_id
  end

end

Spree::Api::V1::StockLocationsController.prepend Spree::Api::V1::StockLocationsControllerDecorator
