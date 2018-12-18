class SubscribeUnsubscribeEmailJob < ApplicationJob
  queue_as :default

  def perform(app_name, recipient, subscribe)
  	if subscribe.present?
  		SendSingleEmailMailer.subscribe(app_name, recipient).deliver
  	else
  		SendSingleEmailMailer.unsubscribe(app_name, recipient).deliver
  	end    
  end
end
