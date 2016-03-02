class AddAttachmentPictureToPortfolios < ActiveRecord::Migration
  def self.up
    change_table :portfolios do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :portfolios, :picture
  end
end
