require 'logger'
#
class Project::NotifyClientProjectReceivedWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :mailer
  def perform(project_id)
    @project = Project.find(project_id)
    email_information = @project.project_payload
    Project::ProjectMailer.notify_client_project_received(email_information).deliver
  end
end
