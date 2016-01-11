class AddVentaToProducto < ActiveRecord::Migration
  def change
    add_column :productos, :venta, :float
  end
end
