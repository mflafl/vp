class API < Grape::API
  version 'v1'
  format :json
  prefix 'api'
  mount VideoController
  add_swagger_documentation
end
