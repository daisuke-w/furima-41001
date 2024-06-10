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
- has_one  :address

## items テーブル

| Column      | LogicName      | Type       | Options     |
| ----------- | -------------- | ---------- | ----------- |
| user        | ユーザーID     | references | null: false, foreign_key: true |
| status      | 商品状態ID     | references | null: false, foreign_key: true |
| category    | カテゴリーID   | references | null: false, foreign_key: true |
| name        | 商品名         | string     | null: false |
| price       | 値段           | integer    | null: false |
| description | 商品説明       | text       | null: false |

### Association

- belongs_to :user
- has_one    :item_image
- has_one    :item_status
- has_one    :category
- has_one    :shipping_option

## item_images テーブル

| Column | LogicName      | Type       | Options                        |
| ------ | -------------- | ---------- | ------------------------------ |
| item   | 商品ID         | references | null: false, foreign_key: true |
| image  | 商品画像       | text       | null: false                    |

### Association

- belongs_to :item

## item_status テーブル

| Column | LogicName      | Type       | Options        |
| ------ | -------------- | ---------- | -------------- |
| status | 商品状態        | string     | null: false    |

### Association

- belongs_to :item

## categories テーブル

| Column | LogicName      | Type       | Options        |
| ------ | -------------- | ---------- | -------------- |
| name   | カテゴリー     | string     | null: false    |

### Association

- belongs_to :item

## shipping_options テーブル

| Column                | LogicName      | Type       | Options                        |
| --------------------- | -------------- | ---------- | ------------------------------ |
| item                  | 商品ID         | references | null: false, foreign_key: true |
| shipping_cost         | 配送料負担ID   | references | null: false, foreign_key: true |
| shipping_duration     | 発送日数ID     | references | null: false, foreign_key: true |
| shipping_prefecture   | 発送元ID       | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- has_one    :shipping_cost
- has_one    :shipping_duration
- belongs_to :prefecture
- belongs_to :order

## shipping_costs テーブル

| Column | LogicName      | Type       | Options        |
| ------ | -------------- | ---------- | -------------- |
| cost   | 配送料負担      | string     | null: false    |

### Association

- belongs_to :shipping_option

## shipping_durations テーブル

| Column   | LogicName      | Type       | Options        |
| -------- | -------------- | ---------- | -------------- |
| duration | 発送日程        | string     | null: false    |

### Association

- belongs_to :shipping_option

## prefectures テーブル

| Column  | LogicName      | Type       | Options        |
| ------- | -------------- | ---------- | -------------- |
| name    | 都道府県        | string      | null: false    |

### Association

- has_one  :shipping_option
- has_many :address

## orders テーブル

| Column          | LogicName            | Type       | Options                        |
| --------------- | -------------------- | ---------- | ------------------------------ |
| user            | ユーザーID            | references | null: false, foreign_key: true |
| address         | 住所ID               | references | null: false, foreign_key: true |
| shipping_option | 配送オプションID      | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one    :address
- has_one    :shipping_option
- has_one    :item, through: :shipping_option

## address テーブル

| Column      | LogicName      | Type       | Options     |
| ----------- | -------------- | ---------- | ----------- |
| user        | ユーザーID      | references | null: false, foreign_key: true |
| prefecture  | 都道府県ID      | references | null: false, foreign_key: true |
| postal_code | 郵便番号        | string     | null: false |
| city        | 市区町村        | string     | null: false |
| town        | 丁目           | string     | null: false |
| block       | 番地           | string     | null: false |
| building    | 建物名         | string     | null: false |
| phone       | 電話番号       | string     | null: false |

### Association

- belongs_to :user
- belongs_to :prefecture
- belongs_to :order