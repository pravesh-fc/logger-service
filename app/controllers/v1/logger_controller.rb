class V1::LoggerController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    begin
      logs = Log.all.group_by(&:log_type).as_json(:except => [:id, :app_name])
      event = Event.last
      render :json => { data: {logs: logs, event: event}, status: 200 }
    rescue Exception => exception
      render :json => { message: exception.message, status: 500}
    end
  end

  def create_event
    begin
      event = Event.create(app_name: request.headers["SERVER_NAME"],
                  name: params[:event][:name],
                  details: params[:event][:details],
                  start_date: params[:event][:start_date],
                  end_date: params[:event][:end_date])
      SendEmailForUpdatesJob.perform_now(event, request.headers["SERVER_NAME"])
      render :json => { status: 200 }
    rescue Exception => exception
      render :json => { message: exception.message, status: 500}
    end
  end
end
