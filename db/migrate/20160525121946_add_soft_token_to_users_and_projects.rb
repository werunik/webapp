class AddSoftTokenToUsersAndProjects < ActiveRecord::Migration
  def change
    add_column :users, :soft_token, :string
    add_column :projects, :soft_token, :string
  end
end
