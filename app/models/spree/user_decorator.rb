module Spree::UserDecorator

  def self.prepended(base)
    base.belongs_to :supplier, class_name: Spree::Supplier.to_s

    base.has_many :variants, through: :supplier
  end

  def supplier?
    supplier.present?
  end

end

Spree::User.prepend Spree::UserDecorator
