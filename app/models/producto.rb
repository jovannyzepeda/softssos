class Producto < ActiveRecord::Base
  belongs_to :producto_padre
end
