class AddUidToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :uid, :string
  end
end
