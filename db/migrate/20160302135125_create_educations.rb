class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :university
      t.string :course
      t.date :finishdate
      t.string :level
      t.belongs_to :profile, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
