class Attachment < ActiveRecord::Base
  mount_uploader :file, FileUploader
  belongs_to :attachable, polymorphic: true
end
