class UserBalance < ApplicationRecord
    belongs_to :user
    
    validates :currency, presence: true
    validates :amount, presence: true
end
