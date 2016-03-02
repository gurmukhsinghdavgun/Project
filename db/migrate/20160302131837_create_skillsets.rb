class CreateSkillsets < ActiveRecord::Migration
  def change
    create_table :skillsets do |t|
      t.belongs_to :profile, index: true, foreign_key: true
      t.belongs_to :skill, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
