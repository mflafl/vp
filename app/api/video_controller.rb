class VideoController < Grape::API
  resource :video do
    get do

    end

    desc 'Creates videos from uploaded files'
    params do
      requires :video, type: Hash do
        optional :files, type: Array do
          requires :file, :type => Rack::Multipart::UploadedFile, :desc => "Video files"
        end
      end
    end
    post do
      params
      # params.video.files.each do |file|
      #     Video.new(:name => 'test')
      # end
    end

    get ':id' do
      'id';
    end
  end
end
