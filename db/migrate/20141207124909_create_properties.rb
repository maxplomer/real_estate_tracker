class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer :user_id, :null => false
      t.string :address, :null => false
      t.string :floor, :null => false
      t.integer :asking_rent, :null => false
      t.integer :rsf_available, :null => false
      t.string :floorplan_url, :null => false
      t.string :picture_url, :null => false

      t.timestamps
    end
  end
end
