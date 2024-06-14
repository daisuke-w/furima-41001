class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references  :order,           null: false, foreign_key: true
      t.integer     :prefecture_id,   null: false
      t.string      :postal_code,     null: false
      t.string      :city,            null: false
      t.string      :block,           null: false
      t.string      :building
      t.string      :phone,           null: false
      t.timestamps
    end
  end
end
