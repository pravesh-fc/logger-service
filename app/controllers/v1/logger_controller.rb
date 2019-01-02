class V1::LoggerController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    begin
      logs = Log.where('created_at > ?', 24.hours.ago).group(:log_type, "date_format(created_at, '%Y%m%d %H')", :status).count
      event = Event.last
      render :json => { data: {logs: logs, event: event}, status: 200 }
    rescue Exception => exception
      render :json => { message: exception.message, status: 500}
    end
  end

  def get_logs_by_duration
    begin
      param_duration = params[:duration]
      render :json => { message: "No parameter found", status: 404 } unless param_duration.present?
      if param_duration.to_i == 0
        logs = Log.where('created_at > ?', 24.hours.ago).group(:log_type, "date_format(created_at, '%Y%m%d %H')", :status).count
      elsif param_duration.to_i == 1
        logs = Log.where('created_at > ?', 1.month.ago).group(:log_type, "date_format(created_at, '%Y %m %d')", :status).count
      else
        logs = Log.where('created_at > ?', 1.year.ago).group(:log_type, "date_format(created_at, '%Y %m')", :status).count
      end
      render :json => { data: {logs: logs}, status: 200 }
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
      SendEmailForUpdatesJob.perform_in(30.seconds, event, request.headers["SERVER_NAME"])
      render :json => { status: 200 }
    rescue Exception => exception
      render :json => { message: exception.message, status: 500}
    end
  end
end
