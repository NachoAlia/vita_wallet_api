class Transaction < ApplicationRecord
    belongs_to :user
    enum transaction_type: { purchase: 0, sale: 1 }

    validates :currency_from, presence: true
    validates :currency_to, presence: true
    validates :amount, presence: true
    validates :transaction_type, presence: true
end
