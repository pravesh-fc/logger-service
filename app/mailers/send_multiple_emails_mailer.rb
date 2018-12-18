class SendMultipleEmailsMailer < ApplicationMailer
  	def send_updates(recipient, update)
  		@recipient = recipient
	    @update = update
	    mail(
	      to: recipient, 
	      subject: "UPDATE: #{@update.name}"
	    )
  	end
end
