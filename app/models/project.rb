class Project < ActiveRecord::Base
  belongs_to :user
  validates :name, :budget, :start, :project_type, :owner_name, :email,
            presence: true
end