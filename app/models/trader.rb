class Trader < ApplicationRecord
    acts_as_token_authenticatable
    # has_secure_password

    has_many :items, -> { order('created_at DESC') }
    has_many :orders, -> { order('created_at DESC') }
    has_many :trader_categories
    has_many :categories, -> { order('name ASC') }, through: :trader_categories
end
