class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :property_id, :null => false
      t.string :name, :null => false
      t.string :title, :null => false
      t.string :email, :null => false
      t.string :company, :null => false
      t.string :phone, :null => false

      t.timestamps
    end
  end
end
