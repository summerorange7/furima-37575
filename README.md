# README

## usersテーブル

|Column   |Type   |Options    |
|---------|-------|-----------|
|nickname |string |null: false|
|familyname |string |null: false|
|firstname|string |null: false|
|familyname_kana |string |null: false|
|firstname_kana |string |null: false|
|email |string |null: false, unique: true|
|encrypted_password |string |null: false|
|birthday |date |null: false|

### Association
- has_many :items
- has_many :buys

## itemsテーブル

|Column   |Type   |Options    |
|---------|-------|-----------|
|title |string |null: false|
|description |text |null: false|
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
|item|references|null: false, foreign_key: true|
|user|references|null: false, foreign_key: true|


## Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addressesテーブル

|Column   |Type   |Options    |
|---------|-------|-----------|
|postal_code|string|null: false|
|prefecture_id|integer|null: false|
|town|string|null: false|
|living_area|string|null: false|
|building|string||
|telephone|string|null: false|
|buy|references|null: false, foreign_key: true|

## Association

- belongs_to :buy