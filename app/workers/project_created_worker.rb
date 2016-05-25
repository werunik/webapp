require 'logger'
#
class ProjectCreatedWorker
  include Sidekiq::Worker
  sidekiq_options :queue => :mailer
  def perform(project_id)
    @project = Project.find(project_id)
    email_information = @project.email_project
    ProjectMailer.project_created(email_information).deliver
  end
end
