class Parent < ApplicationRecord
    has_many :categories, class_name: "Category"
end
