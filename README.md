# README

## usersテーブル

|Column   |Type   |Options    |
|---------|-------|-----------|
|nickname |string |null: false|
|familyname |string |null: false|
|firstname|string |null: false|
|familyname_kana |string |null: false|
|firstname_kana |string |null: false|
|e-mail |string |null: false, unique: true|
|encrypted_password |string |null: false|
|birthday |string |null: false|

### Association
- has_many :items
- has_many :buys

## itemsテーブル

|Column   |Type   |Options    |
|---------|-------|-----------|
|title |string |null: false|
|description |string |null: false|
|category_id|integer |null: false|
|status_id |integer|null: false|
|delivery_fee_id|integer|null: false|
|prefecture_id|integer|null: false|
|delivery_day_id|integer|null: false|
|price|integer|null: false|
|user|references|null: false, foreign_key: true|

## Association

- belongs_to :user
- has_one :buy


## buysテーブル

|Column   |Type   |Options    |
|---------|-------|-----------|
|item|references|null: false, foreign-key: true|
|user|references|null: false, foreign-key: true
|category_id|integer|null: false|
|prefecture_id|integer|null: false|
|town|string|null: false|
|living_area|string|null: false|
|building|string||
|telephone|integer|null: false|

## Association

- belongs_to :user
- has_one :item