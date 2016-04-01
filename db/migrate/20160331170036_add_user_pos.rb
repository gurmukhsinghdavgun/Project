class AddUserPos < ActiveRecord::Migration
  def change
    add_column :profiles, :whatAmI, :string
  end
end
