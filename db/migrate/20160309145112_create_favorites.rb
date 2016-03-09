class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :recruiter, index: true, foreign_key: true
      t.references :favorited, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
