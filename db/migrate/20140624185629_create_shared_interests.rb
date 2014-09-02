class CreateSharedInterests < ActiveRecord::Migration
  def change
    create_table :shared_interests do |t|
      t.string :interest
      t.references :user, index: true
      t.references :match, index: true

      t.timestamps
    end
  end
end
