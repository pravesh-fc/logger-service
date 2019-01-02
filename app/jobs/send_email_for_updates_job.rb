class SendEmailForUpdatesJob < ApplicationJob
  queue_as :mailers

  def perform(event, app_name)
  	@recipients = Subscription.where(app_name: app_name)
		@recipients.each do |recipient|
			SendMultipleEmailsMailer.send_updates(recipient, event).deliver
		end
  end
end
