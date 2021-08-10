class User < ApplicationRecord
    acts_as_token_authenticatable
    has_secure_password
    has_many :carts, -> { order('created_at DESC') }
    has_many :orders, -> { order('created_at DESC') }
    has_many :order_items


    validates :username, uniqueness: { case_sensitive: false }, presence: true, length: {maximum: 20, minimum:4}
    validates :email, uniqueness: { case_sensitive: false }, presence: true, length: {maximum: 50, minimum:5}
end
