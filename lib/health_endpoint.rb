module HealthEndpoint
  require 'net/http'
  require 'uri'
  class Middleware
    def ping(app)
      uri = URI.parse(app)
      response = Net::HTTP.get_response(uri)
      response.code
    end
  end
end