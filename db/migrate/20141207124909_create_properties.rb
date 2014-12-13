class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.integer :user_id, :null => false
      t.string :address, :null => false
      t.string :floor, :null => false
      t.integer :asking_rent, :null => false
      t.integer :rsf_available, :null => false

      #values for analysis
      t.float :income, :null => false
      t.float :expenses, :null => false
      t.float :purchase_price, :null => false
      t.float :interest_rate, :null => false
      t.float :loan_amount, :null => false
      t.boolean :interest_only, :null => false
      t.integer :amortization, :null => false

      t.timestamps
    end
  end
end
