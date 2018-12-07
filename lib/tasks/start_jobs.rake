namespace :app do
  desc "starting jobs"
  task :start_jobs => :environment do
    CheckApplicationHealthJob.perform_now()
    CheckPaymentGatewayJob.perform_now()
  end
end