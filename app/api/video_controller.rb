class VideoController < Grape::API
  before do
    header 'Access-Control-Allow-Origin', '*'
    header 'Access-Control-Allow-Headers', 'Content-Type'
  end

  resource :video do
    desc 'Get video list'
    get :rabl => 'video/list' do
      @items = Video.all
    end

    desc 'Get video by id'
    get ':id', :rabl => 'video/detail' do
      @item = Video.find(params[:id])
    end

    desc 'Creates video from url'
    params do
      requires :url, type: String
    end
    post 'url' do
      VideoUrlDownload.perform_async(params[:url])
    end

    desc 'Creates videos from uploaded files'
    params do
      requires :video, type: Hash do
        optional :files, type: Array do
          requires :type => Rack::Multipart::UploadedFile, :desc => "Video files"
        end
      end
    end
    post do
      videos = [];
      params.video.files.each do |file|
        video = Video.new(:name => file[:filename], :file => file[:tempfile])
        video.save
        videos.push(video)
      end
      videos
    end
  end
end
