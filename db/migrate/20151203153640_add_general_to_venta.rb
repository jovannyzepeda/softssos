class AddGeneralToVenta < ActiveRecord::Migration
  def change
    add_column :venta, :descuentogeneral, :float
  end
end
