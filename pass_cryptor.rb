require 'bcrypt'

class Pass_hash
    def self.create(password)
        hash = BCrypt::Password.create(password)        
    end

    def validate_hash(password, hash)
        BCrypt::Password.new(hash)  == password  
    end
end