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

  belongs_to :user
  has_one    :order

  # エラーメッセージ定義
  error_message = "can't be blank"

  # バリデーション
  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :category_id,           numericality: { other_than: 1, message: error_message }
    validates :status_id,             numericality: { other_than: 1, message: error_message }
    validates :shipping_cost_id,      numericality: { other_than: 1, message: error_message }
    validates :prefecture_id,         numericality: { other_than: 1, message: error_message }
    validates :shipping_duration_id,  numericality: { other_than: 1, message: error_message }
    validates :price,                 numericality: { only_integer: true,
                                                      greater_than_or_equal_to: 300,
                                                      less_than_or_equal_to: 9_999_999 }
  end
end
