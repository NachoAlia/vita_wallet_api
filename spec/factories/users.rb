FactoryBot.define do
    factory :user do
      username { 'usertest' }
      email { 'user@example.com' }
      password { 'secretpassword' }
      password_confirmation { 'secretpassword' }
    end
end