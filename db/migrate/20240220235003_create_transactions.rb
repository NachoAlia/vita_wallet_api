class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :currency_from, limit: 3, null: false
      t.string :currency_to, limit: 3, null: false
      t.decimal :amount, precision: 18, scale: 8, null: false
      t.integer :transaction_type, null: false, default: 0

      t.timestamps
    end
  end
end
