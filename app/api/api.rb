class API < Grape::API
  version 'v1'
  prefix 'api'
  format :json
  formatter :json, Grape::Formatter::Rabl
  add_swagger_documentation
  mount VideoController
end
