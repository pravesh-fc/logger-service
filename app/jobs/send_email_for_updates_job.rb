class SendEmailForUpdatesJob < ApplicationJob
  queue_as :default

  def perform(event, app_name)
  	@recipients = Subscription.where(app_name: app_name)
	@recipients.each do |recipient|
		SendMultipleEmailsMailer.send_updates(recipient, event).deliver_later
	end
  end
end
