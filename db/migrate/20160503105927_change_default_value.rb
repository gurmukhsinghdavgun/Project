class ChangeDefaultValue < ActiveRecord::Migration
  def change
    change_column :profiles, :willingToRelocate, :boolean, default: false
    change_column :profiles, :workAbroad, :boolean, default: false
  end
end
