class AddScoreToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :score, :integer
  end
end
