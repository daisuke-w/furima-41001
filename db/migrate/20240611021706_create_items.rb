class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references  :user,                  null: false, foreign_key: true
      t.integer     :category_id,           null: false
      t.integer     :status_id,             null: false
      t.integer     :shipping_cost_id,      null: false
      t.integer     :prefecture_id,         null: false
      t.integer     :shipping_duration_id,  null: false
      t.string      :name,                  null: false
      t.integer     :price,                 null: false
      t.text        :description,           null: false
      t.timestamps
    end
  end
end
