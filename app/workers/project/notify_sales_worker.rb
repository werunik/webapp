require 'logger'
#
class Project::NotifySalesWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :mailer
  def perform(project_id)
    @project = Project.find(project_id)
    email_information = @project.project_payload
    Project::ProjectMailer.notify_sales(email_information).deliver
  end
end
