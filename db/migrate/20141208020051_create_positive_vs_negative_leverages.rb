class CreatePositiveVsNegativeLeverages < ActiveRecord::Migration
  def change
    create_table :positive_vs_negative_leverages do |t|
      t.integer :user_id, :null => false
      t.float :purchase_price, :null => false
      t.float :cap_rate, :null => false
      t.float :loan_amount, :null => false
      t.float :low_interest_rate, :null => false
      t.float :high_interest_rate, :null => false
      t.boolean :interest_only, :null => false
      t.integer :amortization, :null => false

      t.timestamps
    end
  end
end
