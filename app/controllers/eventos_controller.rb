class EventosController < ApplicationController
	before_action :auth
  def index
  	@padre = ProductoPadre.all
  	@data = params[:data]
  	@cliente = params[:cliente]
  	unless @data.blank?
  		@rols = Rol.all
  		@object = []
  		@cant = []
  	 	@data.each do |d|
  	 		info = Producto.where("nombre=?", d["nombre"])
  		 	@object.push info
  		 	@cant.push d["cantidad"]
  		end

	  end
  end
end
