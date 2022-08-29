class User < ApplicationRecord
    # These two expressions are doing the same thing
    # validates(:name, { presence: true } )
    validates :name, presence: true
end
