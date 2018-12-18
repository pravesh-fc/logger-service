class SendSingleEmailMailer < ApplicationMailer
	def subscribe(app_name, recipient)
	    @recipient = recipient
	    @app_name = app_name
	    mail(
	      to: recipient, 
	      subject: "successfully subscribed to #{@app_name}"
	    )
  	end

	def unsubscribe(app_name, recipient)
	    @recipient = recipient
	    @app_name = app_name
	    mail(
	      to: recipient, 
	      subject: "unsubscribed successfully from #{@app_name}"
	    )
  	end
end
