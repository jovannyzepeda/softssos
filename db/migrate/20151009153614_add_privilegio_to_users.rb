class AddPrivilegioToUsers < ActiveRecord::Migration
  def change
    add_column :users, :privilegio, :integer
  end
end
