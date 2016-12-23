class Video < ApplicationRecord
  has_attached_file :file
  validates_attachment :file, content_type: { content_type: ["application/x-matroska", "video/x-matroska"] }
end
