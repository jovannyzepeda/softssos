class AddBusquedaToProducto < ActiveRecord::Migration
  def change
    add_column :productos, :busqueda, :text
  end
end
