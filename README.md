# テーブル設計

## users テーブル

| Column             | LogicName      | Type   | Options     |
| ------------------ | -------------- | ------ | ----------- |
| nickname           | ニックネーム   | string | null: false |
| email              | メールアドレス | string | null: false, unique: true |
| encrypted_password | パスワード     | string | null: false |
| family_name        | 苗字           | string | null: false |
| first_name         | 名前           | string | null: false |
| family_name_kana   | 苗字_カナ      | string | null: false |
| first_name_kana    | 名前_カナ      | string | null: false |
| birthday           | 誕生日         | date   | null: false |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column               | LogicName      | Type       | Options     |
| -------------------- | -------------- | ---------- | ----------- |
| user                 | ユーザーID     | references  | null: false, foreign_key: true |
| category_id          | カテゴリーID   | integer     | null: false |
| status_id            | 商品状態ID     | integer     | null: false |
| shipping_cost_id     | 配送料負担ID   | integer     | null: false |
| prefecture_id        | 発送元ID       | integer     | null: false |
| shipping_duration_id | 発送日数ID     | integer     | null: false |
| name                 | 商品名         | string      | null: false |
| price                | 値段           | integer    | null: false |
| description          | 商品説明       | text       | null: false |

### Association

- belongs_to :user
- has_one    :order


## orders テーブル

| Column   | LogicName  | Type       | Options                        |
| -------- | ---------- | ---------- | ------------------------------ |
| user     | ユーザーID  | references | null: false, foreign_key: true |
| item     | 商品ID     | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one    :address

## addresses テーブル

| Column        | LogicName      | Type       | Options     |
| ------------- | -------------- | ---------- | ----------- |
| order         | 注文ID          | references | null: false, foreign_key: true |
| prefecture_id | 都道府県ID      | integer    | null: false |
| postal_code   | 郵便番号        | string     | null: false |
| city          | 市区町村        | string     | null: false |
| town          | 丁目           | string     | null: false |
| block         | 番地           | string     | null: false |
| building      | 建物名         | string     |             |
| phone         | 電話番号       | string     | null: false |

### Association

- belongs_to :order