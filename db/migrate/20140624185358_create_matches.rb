class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :name
      t.string :image
      t.string :relationship_status
      t.string :religion
      t.string :gender
      t.string :location
      t.integer :match_percent
      t.references :user, index: true

      t.timestamps
    end
  end
end
