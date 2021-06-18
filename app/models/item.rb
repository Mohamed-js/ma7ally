class Item < ApplicationRecord
    has_many :orders
    belongs_to :trader
    belongs_to :category
end
