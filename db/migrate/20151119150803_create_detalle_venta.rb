class CreateDetalleVenta < ActiveRecord::Migration
  def change
    create_table :detalle_venta do |t|
      t.references :Venta, index: true, foreign_key: true
      t.string :producto
      t.integer :cantidad
      t.float :precio
      t.float :descuento

      t.timestamps null: false
    end
  end
end
