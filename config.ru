# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

require 'rack/cors'

use Rack::Cors do
  allow do
    origins '*'
    resource '*', headers: :any, methods: :get
  end
end

use Rack::Config do |env|
  env['api.tilt.root'] = 'app/views'
end

Rabl.configure do |c|
  c.view_paths = [
      Rails.root.join('app/views')
  ]
end

run Rails.application
