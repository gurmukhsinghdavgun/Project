class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :bio
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
