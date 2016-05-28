class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :projects
  after_commit :create_hubspot_contact, on: :create

  def soft_user?
    self.email.empty?
  end

  def needs_engagement?
    projects = Project.where(soft_token: self.soft_token)
    if self.soft_user? && projects.count >= 2
      true
    end
  end

  protected

  def create_hubspot_contact
    initial_payload = { projects: 0 }
    Crm::HubspotContactWorker.perform_async(email, initial_payload)
  end

end