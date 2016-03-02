class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.text :description
      t.references :profile, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
