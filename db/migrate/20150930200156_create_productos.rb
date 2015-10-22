class CreateProductos < ActiveRecord::Migration
  def change
    create_table :productos do |t|
      t.string :nombre
      t.string :clave
      t.float :precio
      t.text :descripcion
      t.references :producto_padre, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
