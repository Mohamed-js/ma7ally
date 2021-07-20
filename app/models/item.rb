class Item < ApplicationRecord
    has_many :orders
    has_many :carts
    belongs_to :trader
    belongs_to :category
end
