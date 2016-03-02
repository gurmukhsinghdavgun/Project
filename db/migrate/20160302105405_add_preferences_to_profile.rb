class AddPreferencesToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :cityToWorkIn, :string
    add_column :profiles, :willingToRelocate, :string
    add_column :profiles, :workAbroad, :string
    add_column :profiles, :salary, :string
    add_column :profiles, :UKauthorization, :string
  end
end
