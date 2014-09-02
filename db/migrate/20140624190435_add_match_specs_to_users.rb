class AddMatchSpecsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :match_gender, :string
    add_column :users, :match_relationship_status, :string
    add_column :users, :match_location, :string
    add_column :users, :match_religion, :string
  end
end
