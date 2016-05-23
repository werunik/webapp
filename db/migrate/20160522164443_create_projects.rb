class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false, default: ""
      t.string :budget, null: false, default: "I don't know"
      t.string :start, null: false, default: ""
      t.string :project_type, null: false, default: ""
      t.text :description
      t.string :owner_name, null: false, default: ""
      t.string :phone
      t.string :email, null: false, default: ""

      t.timestamps null: false
    end
  end
end
