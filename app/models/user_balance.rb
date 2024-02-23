class UserBalance < ApplicationRecord
    belongs_to :user
    
    validates :currency, presence: true
    validates :amount, presence: true

    def can_deduct?(amount)
        self.amount >= amount
    end

    def deduct(amount)
        self.amount -= amount
        self.save!
    end

    def add(amount)
        self.amount += amount
        self.save!
    end

    def self.deposit(user_id, currency, amount)
        user_balance = UserBalance.find_or_create_by(user_id: user_id, currency: currency)
        user_balance.amount += amount.to_f
        user_balance.save
        user_balance
    end
end
