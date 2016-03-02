class AddSkillsRolesToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :experiance, :string
    add_column :profiles, :mostInterest, :string
  end
end
