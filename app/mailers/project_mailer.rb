class ProjectMailer < ActionMailer::Base
  def project_created(email_information = {})
    payload = {
      recipients: {
        list_id: 'sales'
      },
      substitution_data: {
        project: {
          project_id: email_information[:project_id],
          project_owner_email: email_information[:project_owner_email],
          project_owner_name: email_information[:project_owner_name]
          #project_title: email_information[:project_title],
          #project_category: email_information[:project_category],
          #project_message: email_information[:project_message]
        }
      },
      content: {
        template_id: 'project-new'
      }
    }
    sp = SparkPost::Client.new(Rails.application.secrets.sparkpost)
    sp.transmission.send_payload(payload)
  end
end