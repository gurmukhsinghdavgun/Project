class AddPersonalToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :name, :string
    add_column :profiles, :location, :string
    add_column :profiles, :phone, :string
  end
end
