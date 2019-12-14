module Spree::Admin::ProductsControllerDecorator

  def self.prepended(base)
    base.before_action :get_suppliers, only: [:edit, :update]
    base.before_action :supplier_collection, only: [:index]
  end

  private

  def get_suppliers
    @suppliers = Spree::Supplier.order(:name)
  end

  # Scopes the collection to the Supplier.
  def supplier_collection
    if try_spree_current_user && !try_spree_current_user.admin? && try_spree_current_user.supplier?
      @collection = @collection.joins(:suppliers).where('spree_suppliers.id = ?', try_spree_current_user.supplier_id)
    end
  end

end

Spree::Admin::ProductsController.prepend Spree::Admin::ProductsControllerDecorator
