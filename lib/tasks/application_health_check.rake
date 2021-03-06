require 'net/http'
require 'uri'
namespace :app do
  desc "application health"
  task :application_health => :environment do
    app = 'chartrequest.com'
    log = Log.create(app_name: app,
               status: 'ok',
               log_type: 0)
    uri = URI.parse("https://" + app)
    response = Net::HTTP.get_response(uri)
    if response.code == "200"
      log.update(status: 'ok')
    end
  end
end