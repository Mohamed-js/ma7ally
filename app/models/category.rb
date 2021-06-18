class Category < ApplicationRecord
    has_many :items
    has_many :trader_categories
    has_many :traders, through: :trader_categories
end
