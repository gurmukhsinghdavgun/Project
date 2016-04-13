class AddTypeToEducations < ActiveRecord::Migration
  def change
    add_column :educations, :degreetype, :string
  end
end
