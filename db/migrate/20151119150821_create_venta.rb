class CreateVenta < ActiveRecord::Migration
  def change
    create_table :venta do |t|
      t.string :cliente
      t.string :clave
      t.date :fecha
      t.float :iva

      t.timestamps null: false
    end
  end
end
