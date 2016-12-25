class Video < ApplicationRecord
  has_attached_file :file, validate_media_type: false
  validates_attachment_file_name :file, :matches => [/mkv\Z/]
end
