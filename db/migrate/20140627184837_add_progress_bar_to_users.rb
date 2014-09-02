class AddProgressBarToUsers < ActiveRecord::Migration
  def change
    add_column :users, :progress_bar, :integer, default: 0
  end
end
