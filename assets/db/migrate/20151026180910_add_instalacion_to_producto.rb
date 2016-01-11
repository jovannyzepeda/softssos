class AddInstalacionToProducto < ActiveRecord::Migration
  def change
    add_column :productos, :instalacion, :integer
  end
end
