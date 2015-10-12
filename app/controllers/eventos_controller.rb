class EventosController < ApplicationController
	before_action :auth
  def index
  	@padre = ProductoPadre.all
  	@data = params[:data]
  	unless @data.blank?
  		@rols = Rol.all
  		@object = []
	 	@data.each do |d|
	 		info = Producto.where("nombre=?", d)
		 	@object.push info
		end
		respond_to do |format|
	          format.html
	          format.xlsx
	    end
	end
  end

end
