module Auth
    require 'bcrypt'
  
    def self.generate_token(user_id)
        BCrypt::Password.create(user_id.to_s)
    end

    def self.valid_token?(token, user_id)
      hashed_token = BCrypt::Password.new(token)
      hashed_token == user_id.to_s
    end

end
