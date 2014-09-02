class AddJobStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :job_status, :string
  end
end
