class V1::SubscriptionsController < ApplicationController
	skip_before_action :verify_authenticity_token
	def subscribe
		begin
			subscription = Subscription.where(app_name: request.headers["SERVER_NAME"], email: params[:subscription][:email])
			render :json => { status: 200, message: "already subscribed" } and return if subscription.present?
			Subscription.create(app_name: request.headers["SERVER_NAME"], email: params[:subscription][:email])
			SendSingleEmailMailer.subscribe(request.headers["SERVER_NAME"], params[:subscription][:email]).deliver
			render :json => { status: 200, message: "subscribed" }
		rescue Exception => exception
	      render :json => { message: exception.message, status: 500}
	    end
	end

	def unsubscribe
		begin
			subscription = Subscription.where(app_name: request.headers["SERVER_NAME"], email: params[:subscription][:email])
			render :json => { message: "email not found", status: 404 } and return unless subscription.present?
			subscription.destroy_all
			SendSingleEmailMailer.unsubscribe(request.headers["SERVER_NAME"], params[:subscription][:email]).deliver
			render :json => { status: 200, message: "unsubscribed successfully" }
		rescue Exception => exception
	      render :json => { message: exception.message, status: 500}
	    end
	end
end
