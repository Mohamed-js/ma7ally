class OrderItem < ApplicationRecord
    belongs_to :order
    belongs_to :item
    belongs_to :trader
    belongs_to :user
end
