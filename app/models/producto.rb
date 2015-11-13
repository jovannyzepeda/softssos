class Producto < ActiveRecord::Base
  	validates :nombre, :presence => true
	validates :clave, :presence => true
	validates :precio, :presence => true
	validates :venta, :presence => true
	validates :instalacion, :presence => true
	validates :instalacionpreencial, :presence => true
	validates :producto_padre_id, :presence => true
  	belongs_to :producto_padre
end
