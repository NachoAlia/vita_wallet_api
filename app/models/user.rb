class User < ApplicationRecord
    has_secure_password

    has_many :user_balances
    has_many :transactions

    validates :username, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true, length: { minimum: 6 }
    validates :password_confirmation, presence: true, length: { minimum: 6 }
    validates_confirmation_of :password
end
