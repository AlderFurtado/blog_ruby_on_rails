class User < ApplicationRecord
    has_secure_password
    validates_uniqueness_of :email , :message => '%{value} já cadastrado'
end
