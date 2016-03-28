class ChangeColumn < ActiveRecord::Migration
  def change
    change_column :profiles, :willingToRelocate, :boolean
  end
end
