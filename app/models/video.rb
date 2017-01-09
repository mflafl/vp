class Video < ApplicationRecord
  has_attached_file :file, validate_media_type: false,
                    :path => ':rails_root/public/video/:filename',
                    :url => 'video/:filename'
  validates_attachment_file_name :file, :matches => [/mp4\Z/]

  def url
    URI.join(ActionController::Base.asset_host, self.file.url)
  end
end
