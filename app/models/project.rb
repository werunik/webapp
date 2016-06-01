class Project < ActiveRecord::Base
  belongs_to :user
  validates :name, :budget, :start, :owner_name, :email,
            presence: true
  validates :project_type, presence: true,
            inclusion: { in: %w(Website Backend Frontend UI UX Design Other)}
  validates :budget, presence: true,
            inclusion: { in: ["$5k - $10k", "$10k - $20k", "$20k - $50k", "$50k+", "I don't know"]}
  #validates :start, presence: true,
  #          inclusion: { in: %w("Now!" "1week" "2weeks" "1month" "2months")}
  after_commit :notification_project_received, on: :create

  def notification_project_received
    Project::NotifyClientProjectReceivedWorker.perform_in(1.minutes, id)
    Project::NotifySalesWorker.perform_async(id)
  end

  def project_payload
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