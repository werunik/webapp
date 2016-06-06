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
    if self.soft_user? && projects.count >= 1
      true
    end
  end

  protected

  def create_hubspot_contact
    intial_information = { project_count: 0 }
    Analytics::HubspotContactWorker.perform_async(email, intial_information)
  end
end
