class VideoCrop
  include Sidekiq::Worker
  def perform(params)
    video = Video.find(params['id'])
    ActionCable.server.broadcast 'video_add_channel', { type: 'crop_complete', data: video.id }
  end
end