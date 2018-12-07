class ApplicationController < ActionController::Base
  before_action :whitelist_ip

  private
  def whitelist_ip
    head :unauthorized unless %w(127.0.0.1 app.chartrequest.com chartrequest.com).include?(request.ip)
  end
end
