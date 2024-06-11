class Item < ApplicationRecord
  # ActiveHash moduleの読込
  extend ActiveHash::Associations::ActiveRecordExtensions

  # アソシエーション
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :shipping_duration
  has_one_attached :image

  # バリデーション
  with_options presence: true do
    validates :category_id,           numericality: { other_than: 1 }
    validates :status_id,             numericality: { other_than: 1 }
    validates :shipping_cost_id,      numericality: { other_than: 1 }
    validates :prefecture_id,         numericality: { other_than: 1 }
    validates :shipping_duration_id,  numericality: { other_than: 1 }
    validates :name
    validates :price,                 numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
    validates :description
  end
end
