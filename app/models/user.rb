class User < ApplicationRecord
    before_save { email.downcase! }

    # constants are indcated with all caps
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    
    # These two expressions are doing the same thing
    # validates(:name, { presence: true } )
    # validates :name, presence: true

    validates :name, presence: true, length: { maximum: 50 }
    validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX}, uniqueness: true
end
