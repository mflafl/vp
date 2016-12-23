class VideoController < Grape::API
  resource :video do
    desc 'Creates videos from uploaded files'
    params do
      requires :video, type: Hash do
        optional :files, type: Array do
          requires :type => Rack::Multipart::UploadedFile, :desc => "Video files"
        end
      end
    end
    post do
      params.video.files.each do |file|
        video = Video.new(:name => 'test', :file => file[:tempfile])
        video.save
      end
      "test"
    end
  end
end
