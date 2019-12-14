module Ckeditor::AssetDecorator

  def self.prepended(base)
    base.belongs_to :supplier, class_name: Spree::Supplier.to_s
  end

end

if defined?(Ckeditor::Asset)
  Ckeditor::Asset.prepend Ckeditor::AssetDecorator
end
