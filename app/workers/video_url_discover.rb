class VideoUrlDiscover
  include Sidekiq::Worker
  def perform(url)
    video = YoutubeDL.get url, {skip_download: true}
    # data = Video.new(:name => video.fulltitle)
    # data.save
    ActionCable.server.broadcast 'video_add_channel', { type: 'discover', data: video.fulltitle }
  end
end