class AddColumnUserToVenta < ActiveRecord::Migration
  def change
    add_reference :venta, :user, index: true, foreign_key: true
  end
end
