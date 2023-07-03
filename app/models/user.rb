class User < ApplicationRecord
    has_many :recipes
    has_secure_password
  
    validates :username, uniqueness: true, presence: true
end
  