
class VideoAddChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'video_add_channel'
  end

  def unsubscribed
  end
end