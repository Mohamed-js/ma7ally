class TraderCategory < ApplicationRecord
    belongs_to :trader
    belongs_to :category
end
