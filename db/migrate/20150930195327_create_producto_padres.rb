class CreateProductoPadres < ActiveRecord::Migration
  def change
    create_table :producto_padres do |t|
      t.string :nombre
      t.text :descripcion

      t.timestamps null: false
    end
  end
end
