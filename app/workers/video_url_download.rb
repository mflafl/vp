class VideoUrlDownload
  include Sidekiq::Worker
  def perform(url)
    info = YoutubeDL.get url, {skip_download: true}
    ActionCable.server.broadcast 'video_add_channel', { type: 'discover', data: info.fulltitle }

    preset = 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio'
    path = "public/video/#{info.id}.#{info.ext}"
    file = YoutubeDL.get url, {format: preset, output: path}
    video = Video.new(:name => file.fulltitle, :file => File.new(file._filename))
    video.save!

    ActionCable.server.broadcast 'video_add_channel', { type: 'complete', data: video.id }
  end
end