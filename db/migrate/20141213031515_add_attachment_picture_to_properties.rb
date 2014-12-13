class AddAttachmentPictureToProperties < ActiveRecord::Migration
  def self.up
    change_table :properties do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :properties, :picture
  end
end
