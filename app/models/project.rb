class Project < ActiveRecord::Base
  validates :name, :budget, :start, :project_type, :owner_name, :email,
            presence: true
end
