class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # 正規表現を定義
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  ZENKAKU_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  ZENKAKU_KANA_REGEX = /\A[ァ-ヶー]+\z/

  # エラーメッセージ定義
  error_zenkaku = 'Full-width characters'
  error_zenkaku_kana = 'Full-width kana characters'
  error_password_both = 'Includes both letters and numbers'

  # 新規登録時のバリデーション 空欄は共通でNG
  with_options presence: true do
    validates :nickname
    
    # 全角文字であること
    validates :family_name,       format: { with: ZENKAKU_REGEX, message: error_zenkaku }
    validates :first_name,        format: { with: ZENKAKU_REGEX, message: error_zenkaku }
    
    # 全角カナ文字であること
    validates :family_name_kana,  format: { with: ZENKAKU_KANA_REGEX, message: error_zenkaku_kana }
    validates :first_name_kana,   format: { with: ZENKAKU_KANA_REGEX, message: error_zenkaku_kana }
    
    validates :birthday

    # 文字と数字を含んでいること
    validates_format_of :password, with: PASSWORD_REGEX, message: error_password_both
  end
end
