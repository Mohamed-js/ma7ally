class Trader < ApplicationRecord
    acts_as_token_authenticatable
    has_secure_password

    has_many :items, -> { order('created_at DESC') }
    has_many :orders, -> { order('created_at DESC') }
    has_many :trader_categories
    has_many :categories, -> { order('name ASC') }, through: :trader_categories

    validates :tradername, presence: true, length: {maximum: 20, minimum:4}
    validates :storename, presence: true, length: {maximum: 20, minimum:4}
    validates :email, presence: true, length: {maximum: 50, minimum:5}    
end
