class VideoCrop
  include Sidekiq::Worker
  def perform(params)
    video = Video.find(params['id'])
    file_basename = File.basename(video.file.path, File.extname(video.file.path));
    extension = File.extname(video.file.path);
    output = Rails.root.join('public', 'video', "#{file_basename}-#{params['from']}-#{params['to']}#{extension}")

    system sprintf "ffmpeg -i %<input>s -ss %<start>s -to %<end>s -async 1 %<output>s",
                   { :start => params['from'], :end => params['to'],
                     :input => video.file.path,
                     :output => output
                   }

    video = Video.new(:name => "#{video.name} - CROP #{params['from']} - #{params['to']}", :file => File.new(output))
    video.save!

    ActionCable.server.broadcast 'video_add_channel', { type: 'complete', data: video.id }
  end
end