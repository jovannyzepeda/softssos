class AddStatusToVenta < ActiveRecord::Migration
  def change
    add_column :venta, :status, :string
  end
end
