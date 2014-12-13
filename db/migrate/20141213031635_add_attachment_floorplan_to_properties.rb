class AddAttachmentFloorplanToProperties < ActiveRecord::Migration
  def self.up
    change_table :properties do |t|
      t.attachment :floorplan
    end
  end

  def self.down
    remove_attachment :properties, :floorplan
  end
end
