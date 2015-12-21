class AddDistribuidordesToDetail < ActiveRecord::Migration
  def change
    add_column :details, :descuentoproveedor, :float
  end
end
