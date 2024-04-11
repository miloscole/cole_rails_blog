class Category < ApplicationRecord
  has_and_belongs_to_many :articles
  validates :name, presence: true, length: 3..25, uniqueness: true
end
