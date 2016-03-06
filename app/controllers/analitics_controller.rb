class AnaliticsController < ApplicationController
  def index
  	if params[:inicio] && params[:fin]
  		@array = []
  		@arrayfinal = [] 
  		concentrado = Ventum.where("fecha >= ? and fecha <= ?", params[:inicio], params[:fin])
  		obtener_lista_datos(concentrado)
  		crear_lista_objetos
      @datanio = params[:inicio][0..3]
      @anio = []
      venta_anual(@datanio)
      @estado = 0
      @concentrado.sort_by { |x| x[3] }

  	end
  end

  def show

  end
  private
  def venta_anual(anio)
    enero = Ventum.where("fecha >= ? and fecha <= ?" ,anio+'-01-01',anio+'-01-31').sum(:total)
    @anio.push(["Enero",enero])
    febrero = Ventum.where("fecha >= ? and fecha <= ?" ,anio+'-02-01',anio+'-02-29').sum(:total)
    @anio.push(["Febrero",febrero])
    marzo = Ventum.where("fecha >= ? and fecha <= ?" ,anio+'-03-01',anio+'-03-31').sum(:total)
    @anio.push(["Marzo",marzo])
    abril = Ventum.where("fecha >= ? and fecha <= ?" ,anio+'-04-01',anio+'-04-30').sum(:total)
    @anio.push(["Abril",abril])
    mayo = Ventum.where("fecha >= ? and fecha <= ?" ,anio+'-05-01',anio+'-05-31').sum(:total)
    @anio.push(["Mayo",mayo])
    junio = Ventum.where("fecha >= ? and fecha <= ?" ,anio+'-06-01',anio+'-06-30').sum(:total)
    @anio.push(["Junio",junio])
    julio = Ventum.where("fecha >= ? and fecha <= ?" ,anio+'-07-01',anio+'-07-31').sum(:total)
    @anio.push(["Julio",julio])
    agosto = Ventum.where("fecha >= ? and fecha <= ?" ,anio+'-08-01',anio+'-08-31').sum(:total)
    @anio.push(["Agosto",agosto])
    septiembre = Ventum.where("fecha >= ? and fecha <= ?" ,anio+'-09-01',anio+'-09-30').sum(:total)
    @anio.push(["Septiembre",septiembre])
    octubre = Ventum.where("fecha >= ? and fecha <= ?" ,anio+'-10-01',anio+'-10-31').sum(:total)
    @anio.push(["Octubre",octubre])
    noviembre = Ventum.where("fecha >= ? and fecha <= ?" ,anio+'-11-01',anio+'-11-30').sum(:total)
    @anio.push(["Noviembre",noviembre])
    diciembre = Ventum.where("fecha >= ? and fecha <= ?" ,anio+'-12-01',anio+'-12-31').sum(:total)
    @anio.push(["Diciembre",diciembre])
  end
  def crear_lista_objetos
  	@concentrado = []
  	@product = Producto.all
  	@product.each do |product|
  		cantidad = 0
		  subtotal = 0
		  precio = 0
      venta = 0
	  	@array.each do |filtro|
	  		if filtro.producto == product.nombre
          if filtro.total > 0
  	  			precio = precio + filtro.precio*filtro.cantidad
  		  		subtotal = subtotal.to_f + filtro.total*filtro.cantidad
            venta = venta + filtro.precioventa
          end
		  		cantidad = cantidad + filtro.cantidad
	  		end
  		end
  		if cantidad > 0
        ganacia = subtotal - precio
  			@concentrado.push([product.nombre,precio.round(2),venta.round(2),subtotal.round(2),cantidad,ganacia.round(2)])
		  end
  	end
  end
  def obtener_lista_datos(concentrado)
    sinusuario = 0;
  	concentrado.each do |z|
      if z.user_id
        activo = 0
        posicion = 0
        @arrayfinal.each do |revisar|
          if revisar[0] == z.user.email
            activo = 1
            revisar[1]=revisar[1]+z.total
          end
        end
        unless activo == 1
          @arrayfinal.push([z.user.email,z.total])
        end
      else
        sinusuario = sinusuario + z.total
      end
  		z.detail.each do |x|
  			@array.push(x)
  		end
  	end
    if sinusuario > 0
      @arrayfinal.push(["Sin usuario",sinusuario.round(2)])
    end
  end

  def historico_productos
  	@concentrado = []
  	@product = Producto.all
  	@product.each do |product|
	  	@data = Detail.where("producto=?",	product.nombre)
	  	adicional = 0
	  	subtotal = 0
	  	@data.each do |x|
	  		subtotal = subtotal + x.total
	  		if x.cantidad > 1
	  			adicional = adicional + x.cantidad
	  		end
	  	end
	  	if @data.present?
	  		@concentrado.push([@data.first.producto,(@data.first.precio * (@data.size + adicional)),subtotal,(@data.size + adicional)])
  		end
  	end
  end
end
