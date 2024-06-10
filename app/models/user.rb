class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # Passwordの正規表現を定義
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  
  # 新規登録時のバリデーション 空欄は共通でNG
  with_options presence: true do
    validates :nickname
    
    # 全角文字であること
    validates :family_name,       format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'Full-width characters' }
    validates :first_name,        format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'Full-width characters' }
    
    # 全角カナ文字であること
    validates :family_name_kana,  format: { with: /\A[ァ-ヶー]+\z/, message: 'Full-width kana characters' }
    validates :first_name_kana,   format: { with: /\A[ァ-ヶー]+\z/, message: 'Full-width kana characters' }
    
    validates :birthday

    # 文字と数字を含んでいること
    validates_format_of :password, with: PASSWORD_REGEX, message: 'Includes both letters and numbers'
  end
end
