module Ckeditor::AttachmentFilesControllerDecorator

  def self.prepended(base)
    base.load_and_authorize_resource class: Ckeditor::AttachmentFile.to_s
    base.after_action :set_supplier, only: [:create]
  end

  def index
  end

  private

  def set_supplier
    if try_spree_current_user.supplier? and @attachment
      @attachment.supplier = try_spree_current_user.supplier
      @attachment.save
    end
  end

end

if defined?(Ckeditor::AttachmentFilesController)
  Ckeditor::AttachmentFilesController.prepend Ckeditor::AttachmentFilesControllerDecorator
end
