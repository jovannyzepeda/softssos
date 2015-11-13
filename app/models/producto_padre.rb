class ProductoPadre < ActiveRecord::Base
	validates :nombre, :presence => true
	validates :clave, :presence => true
end
