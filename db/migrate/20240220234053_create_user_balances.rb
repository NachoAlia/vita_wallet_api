class CreateUserBalances < ActiveRecord::Migration[7.0]
  def change
    create_table :user_balances do |t|
      t.references :user, null: false, foreign_key: true
      t.string :currency, limit: 3, null: false
      t.decimal :amount, precision: 18, scale: 8, default: 0.0
      
      t.timestamps default: -> { 'CURRENT_TIMESTAMP' } 
    end
  end
end
