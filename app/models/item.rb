class Item < ApplicationRecord
    has_many :carts
    has_many :order_items
    belongs_to :trader
    belongs_to :category
end
