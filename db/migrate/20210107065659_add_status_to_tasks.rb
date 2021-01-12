class AddStatusToTasks < ActiveRecord::Migration[5.2]
  change_column :tasks, :name, :string, null: false
end
