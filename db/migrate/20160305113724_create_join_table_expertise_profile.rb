class CreateJoinTableExpertiseProfile < ActiveRecord::Migration
  def change
    create_join_table :expertises, :profiles do |t|
      # t.index [:expertise_id, :profile_id]
      # t.index [:profile_id, :expertise_id]
    end
  end
end
