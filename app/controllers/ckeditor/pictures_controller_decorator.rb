module Ckeditor::PicturesControllerDecorator

  def self.prepended(base)
    base.load_and_authorize_resource class: Ckeditor::Picture.to_s
    base.after_action :set_supplier, only: [:create]
  end

  def index
  end

  private

  def set_supplier
    if spree_current_user.supplier? and @picture
      @picture.supplier = spree_current_user.supplier
      @picture.save
    end
  end

end

if defined?(Ckeditor::PicturesController)
  Ckeditor::PicturesController.prepend Ckeditor::PicturesControllerDecorator
end
