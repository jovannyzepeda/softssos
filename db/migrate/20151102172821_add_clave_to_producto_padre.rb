class AddClaveToProductoPadre < ActiveRecord::Migration
  def change
    add_column :producto_padres, :clave, :string
  end
end
