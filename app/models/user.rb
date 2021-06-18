class User < ApplicationRecord
    acts_as_token_authenticatable
    has_secure_password

    has_many :orders, -> { order('created_at DESC') }
end
