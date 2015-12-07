class AddDatosToVenta < ActiveRecord::Migration
  def change
    add_column :venta, :distribuidor, :string
  end
end
