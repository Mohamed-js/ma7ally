class Category < ApplicationRecord
    belongs_to :parent, class_name: "Parent"
    has_many :items
    has_many :trader_categories
    has_many :traders, through: :trader_categories
end
