class ProjectMailer < ActionMailer::Base
  def notify_sales(email_information = {})
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
        template_id: 'notify-sales-project-received'
      }
    }
    sp = SparkPost::Client.new(Rails.application.secrets.sparkpost)
    sp.transmission.send_payload(payload)
  end

  def notify_client_project_received(email_information = {})
    @email_information = email_information
    payload = {
      recipients: [{
        address: {
          email: email_information[:project_owner_email]
        }
      }],
      substitution_data: {
        project: {
          project_id: email_information[:project_id],
          project_owner_email: email_information[:project_owner_email],
          project_owner_name: email_information[:project_owner_name]
        }
      },
      content: {
        template_id: 'notify-client-project-received'
      }
    }
    sp = SparkPost::Client.new(Rails.application.secrets.sparkpost)
    sp.transmission.send_payload(payload)
  end

end