class Trader < ApplicationRecord
    acts_as_token_authenticatable
    has_secure_password

    has_many :items, -> { order('created_at DESC') }
    has_many :orders, -> { order('created_at DESC') }
    has_many :trader_categories
    has_many :categories, -> { order('name ASC') }, through: :trader_categories
    has_many :order_items

    validates :tradername, uniqueness: { case_sensitive: false }, presence: true, length: {maximum: 20, minimum:4}
    validates :storename, uniqueness: { case_sensitive: false }, presence: true, length: {maximum: 20, minimum:4}
    validates :email, uniqueness: { case_sensitive: false }, presence: true, length: {maximum: 50, minimum:5}

    def items_count
        items.count
    end
end
