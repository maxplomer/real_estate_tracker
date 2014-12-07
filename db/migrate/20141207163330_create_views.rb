class CreateViews < ActiveRecord::Migration
  def change
    create_table :views do |t|
      t.integer :property_id, :null => false
      
      t.timestamps
    end
  end
end
