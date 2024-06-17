class OrderAddress
  # ActiveModel::Modelの読込
  include ActiveModel::Model

  # ゲッターセッターの定義
  attr_accessor :user_id, :item_id, :prefecture_id, :postal_code, :city, :block, :building, :phone, :token

  # 正規表現を定義
  POSTALCODE_REGEX = /\A[0-9]{3}-[0-9]{4}\z/
  PHONE_REGEX = /\A0\d{9,10}\z/

  # エラーメッセージ定義
  error_message = "can't be blank"

  # バリデーション
  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :prefecture_id,   numericality: { other_than: 1, message: error_message }
    validates :postal_code,     format: { with: POSTALCODE_REGEX }
    validates :city
    validates :block
    validates :phone,           numericality: { only_integer: true }, format: { with: PHONE_REGEX }
    validates :token
  end

  # 保存処理
  def save
    # ordersテーブルに保存
    order = Order.create(user_id: user_id, item_id: item_id)
    # addressesテーブルに保存
    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      block: block,
      building: building,
      phone: phone,
      order_id: order.id
    )
  end
end
