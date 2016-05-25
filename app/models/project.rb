class Project < ActiveRecord::Base
  belongs_to :user
  validates :name, :budget, :start, :owner_name, :email,
            presence: true
  validates :project_type, presence: true,
            inclusion: { in: %w(Website Backend Frontend UI UX Design Other)}
  def email_project
    #recipients = []
    #recipients << Rails.application.secrets.support_emails
    #recipients << Rails.application.secrets.sales_emails if category == 'quote'
    email_information = {
      #project_owner: user.email,
      project_id: id,
      project_owner_email: email,
      project_owner_name: owner_name
      #project_title: title,
      #project_message: message,
      #project_category: category,
      #project_recipient: recipients
    }
    email_information
  end
end