class ChangeColumnAbroad < ActiveRecord::Migration
  def change
    change_column :profiles, :workAbroad, :boolean
  end
end
