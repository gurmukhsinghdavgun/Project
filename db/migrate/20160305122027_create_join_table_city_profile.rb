class CreateJoinTableCityProfile < ActiveRecord::Migration
  def change
    create_join_table :cities, :profiles do |t|
      # t.index [:city_id, :profile_id]
      # t.index [:profile_id, :city_id]
    end
  end
end
