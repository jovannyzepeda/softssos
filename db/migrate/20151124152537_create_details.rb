class CreateDetails < ActiveRecord::Migration
  def change
    create_table :detail do |t|
      #t.references :venta, index: true, foreign_key: true
      t.text :producto
      t.float :cantidad
      t.float :precio
      t.float :precioventa
      t.float :descuento
      t.float :total
      t.float :descuentoproveedor
      t.timestamps null: false
    end
  end
end
