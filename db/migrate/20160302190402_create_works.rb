class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :companyName
      t.string :position
      t.date :startDate
      t.date :finishDate
      t.text :workDescription
      t.belongs_to :profile, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
