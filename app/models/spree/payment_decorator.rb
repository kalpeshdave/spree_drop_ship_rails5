module Spree::PaymentDecorator

  def self.prepended(base)
    base.belongs_to :payable, polymorphic: true
  end

end

Spree::Payment.prepend Spree::PaymentDecorator
