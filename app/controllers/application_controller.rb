class ApplicationController < ActionController::Base
  before_action :whitelist_ip

  private
  def whitelist_ip
    # head :unauthorized unless %w(127.0.0.1 app.chartrequest.com chartrequest.com 159.65.250.239).include?(request.ip)
  end
end
