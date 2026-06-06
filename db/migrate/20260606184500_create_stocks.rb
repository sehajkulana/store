class CreateStocks < ActiveRecord::Migration[8.1]
  def change
    create_table :stocks do |t|
      t.string :category, null: false
      t.string :name, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :image_path, null: false

      t.timestamps
    end
  end
end
