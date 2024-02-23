require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    puts "User test"
    it 'Usuario con atributos validos' do
      user = User.new(username: 'example_user', email: 'user@example.com', password: 'password', password_confirmation: 'password')
      expect(user).to be_valid
    end
    it 'Usuario con diferentes contraseñas' do
      user = User.new(username: 'example_user', email: 'user@example.com', password: 'password', password_confirmation: 'password1')
      expect(user).not_to be_valid
    end
    it 'Usuario con email existente' do
      user1 = User.new(username: 'example_user', email: 'user@example.com', password: 'password', password_confirmation: 'password')
      user = User.new(username: 'example_user', email: 'user@example.com', password: 'password', password_confirmation: 'password1')
      expect(user).not_to be_valid
    end
    it 'Usuario sin password' do
      user = User.new(username: 'example_user', email: 'user@example.com')
      expect(user).not_to be_valid
    end
    it 'Usuario sin email' do
      user = User.new(username: 'example_user', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
    end
    it 'Usuario sin nombre' do
      user = User.new(email: 'user@example.com', password: 'password', password_confirmation: 'password')
      expect(user).not_to be_valid
    end
    it 'Usuario sin datos' do
      user = User.new()
      expect(user).not_to be_valid
    end
  end
end
