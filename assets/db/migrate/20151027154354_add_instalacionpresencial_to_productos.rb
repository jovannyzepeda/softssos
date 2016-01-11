class AddInstalacionpresencialToProductos < ActiveRecord::Migration
  def change
    add_column :productos, :instalacionpreencial, :integer
  end
end
