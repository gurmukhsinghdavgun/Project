class CreateDevpurchaseds < ActiveRecord::Migration
  def change
    create_table :devpurchaseds do |t|
      t.references :profile, index: true, foreign_key: true
      t.references :recruiter, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :devpurchaseds, [:profile_id, :recruiter_id], :unique => true
  end
end
