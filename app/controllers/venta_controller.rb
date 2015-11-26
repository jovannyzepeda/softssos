class VentaController < ApplicationController
  before_action :auth
  before_action :set_ventum, only: [:show, :edit, :update, :destroy]

  # GET /venta
  # GET /venta.json
  def index
    @venta = Ventum.all
  end

  # GET /venta/1
  # GET /venta/1.json
  def show
    respond_to do |format|
      format.html
      format.xlsx
      format.pdf do
        pdf = Prawn::Document.new
        sos = "#{Rails.root}/public/images/pdf/sos.png" 
        pdf.image sos, :position => :left, :width => 150   
        pdf.draw_text "SOS Software S.A. de C.V.", :at => [300,700]
        pdf.draw_text "Medrano 710; General Real", :at => [300,680]
        pdf.draw_text "Teléfono: (0133) 3617-2968", :at => [300,660]
        pdf.draw_text "E-mail: info@sos-soft.com", :at => [300,640]
        pdf.draw_text "#{@ventum.cliente}", :at => [300,600]
        pdf.text "________________________________________________________________________________"
        pdf.text "<b><font size='24'>\nCotización\n</font></b>", :inline_format => true, :align => :center
        pdf.text "Girada el: #{@ventum.fecha}\n\n\n\n\n ", :align => :right , :inline_format => true
             i = 0
            table_data = [['#', 'Artículo / Descripción', 'Cant', 'Precio unitario', 'Impuesto', 'Descuento','Total']]
             
              @detail.each do |x|
                i = i + 1
                table_data += [[i, x.producto, x.cantidad,x.precioventa,@ventum.iva,x.descuento,x.total]]
              end
          pdf.table(table_data,:width => 540)
          iva = (@ventum.subtotal * ((@ventum.iva.to_f)/100)).round(2)
          pdf.text "\nSub total: #{@ventum.subtotal}\n Impuesto de ventas (#{@ventum.iva.to_i}%): #{iva}\n <b>Total: #{@ventum.total}</b>", :align => :right , :inline_format => true

          pdf.text "\n\n\n\nINFORMACIÓN DE PAGO: SOS Software S.A. de C.V.\n\n
                  BANCO BANORTE: No. Cuenta: 0239431716; CLABE: 072320002394317160\n\n
                    RFC: SOF1406233F5\n\n\n", :inline_format => true

          
          pdf.text "\n\nEstimado cliente, es muy importante validar que cuentas con el suficiente equipo para generar la instalación de nuestros productos o servicios, para ello se recomienda consultar nustro detalle de requerimientos mínimos en el enlace: \nhttp://sos-soft.com/requerimientos.pdf\n\nTe invitamos a consultar los terminos y condiciones de nuestro servicio en el siguiente enlace \nhttp://sos-soft.com/wp-content/uploads/2015/11/Pol--ticas-de-Devolucion-de-productos.pdf", :inline_format => true
         

         


          send_data pdf.render, filename: 'Cotización.pdf', type: 'application/pdf' 
      end
      format.adicional do
       
            pdf = Prawn::Document.new
            sos = "#{Rails.root}/public/images/pdf/sos.png" 
            pdf.image sos, :position => :left, :width => 150   
            pdf.draw_text "SOS Software S.A. de C.V.", :at => [300,700]
            pdf.draw_text "Medrano 710; General Real", :at => [300,680]
            pdf.draw_text "Teléfono: (0133) 3617-2968", :at => [300,660]
            pdf.draw_text "E-mail: info@sos-soft.com", :at => [300,640]
            pdf.text "________________________________________________________________________________"
            pdf.text "<b><font size='24'>\nCarta de aceptación de servicio\n\n\n\n</font></b>", :inline_format => true, :align => :center
            pdf.text "Estimado/a #{@ventum.cliente}\n\nPor medio de este documento se solicita amablemente indicar si el servicio otorgado por SOS Software fue el necesario para cumplir la resolución del inconveniente presentado de una forma adecuada y a su vez generada en un tiempo correspondiente a la dificultad de la solicitud requerida.", :inline_format => true
            pdf.text "\n\nPara poder emitir su factura es necesario responder este mensaje y enviar la siguiente información como contenido de mensaje y con el asunto Carta de aceptación", :inline_format => true, :align => :center
            pdf.text "________________________________________________________________________________"
            pdf.text "\n\nYo #{@ventum.cliente} confirmo que se me dio entrega de los siguientes Productos/servicios:\n\n", :inline_format => true   
            @detail.each do |x|
              pdf.text " * #{x.producto}"
            end
            pdf.text "\n\nA su vez apruebo que esta aceptación sea utilizada por SOS Software para la mejora continua en sus servicios.", :inline_format => true  
            pdf.text "________________________________________________________________________________"
            pdf.text "\n\nMuchas gracis por tu tiempo y recuerda que nuestra misión es ayudarte a administrary controlar mejor tu negocio de una manera automatizada.", :inline_format => true , :align => :center
            pdf.text "\n\nSOS Software SA de CV", :inline_format => :true, :align =>:center 
            pdf.text "\nDesarrollamos tus ideas", :inline_format => :true, :align =>:center 
              
              send_data pdf.render, filename: 'Carta aceptacion.pdf', type: 'application/pdf'
              
          end
    end
  end

  # GET /venta/new
  def new
    @padre = ProductoPadre.all
  end

  # GET /venta/1/edit
  def edit
    @padre = ProductoPadre.all
  end

  # POST /venta
  # POST /venta.json
  def create
    obtener_datos()
    @ventum = Ventum.new(cliente:@cliente, clave:@clave, fecha:@fecha, iva:@iva, subtotal:@preciofinal ,total:@totalcosto)
    respond_to do |format|
        if(@ventum.save)
          salvar()
          format.html { redirect_to @ventum, notice: 'Venta almacenada exitosamente!.' }
        else
          format.html { redirect_to eventos_path, notice: 'Fallo el almacenamiento de la venta.' }
        end
       
    end
  end
  def salvar
    i = 0
    @object.each do |detalle|
      totalpagar = (detalle[0].venta*@cant[i].to_i) * (1 - (@descuento[i].to_f/100))
      @detalle = Detail.new(producto: detalle[0].nombre, cantidad: @cant[i] , precio: detalle[0].precio, precioventa: detalle[0].venta, total: totalpagar , descuento: @descuento[i], venta_id: @ventum.id )
      @detalle.save
      i = i + 1
    end
    if @tiempo_instalar.present?
      @detalle = Detail.new(producto: @activacion, cantidad: @tiempo_instalar , precio: @unicoinstalar, precioventa: @unicoinstalar, total: @costo_instalar , venta_id: @ventum.id )
      @detalle.save
    end
  end
  def obtener_datos
    @data = params[:data]
    @fecha = params[:fecha]
    @clave = params[:clave]
    @iva = params[:iva]
    unless @data.blank?
      @cliente = params[:cliente] + " " +params[:cliente_apellido]
      @object = []
      @cant = []
      @descuento = []
      @venta = []
      @unicoinstalar
      horas = 0
      @preciofinal = 0
      @activacion = params[:instalacion]
      if @activacion != "No"
        horas = params[:tiempoinstalar]
        @data.each do |d|
          info = Producto.where("nombre=?", d["nombre"])
          #if info.first.instalacion
          #  horas= horas + (info.first.instalacion * d["cantidad"].to_i)
          #end
          @object.push info
          @cant.push d["cantidad"]
          @descuento.push d["descuento"]
          @venta.push (info.first.venta * (1 - (d["descuento"].to_f/100)))
          @preciofinal = @preciofinal + (info.first.venta * (1 - (d["descuento"].to_f/100)))
        end
        
        @tiempo_instalar = (horas.to_f/60).round(2)
        if @activacion == "Presencialmente"
          @costo_instalar = @tiempo_instalar * 650
          @unicoinstalar = 650
        elsif @activacion == "Remotamente"
          @costo_instalar = @tiempo_instalar * 550
          @unicoinstalar = 550
        end
        @preciofinal = @preciofinal + @costo_instalar
      else
        @data.each do |d|
          info = Producto.where("nombre=?", d["nombre"])
          @object.push info
          @cant.push d["cantidad"]
          @descuento.push d["descuento"]
          @venta.push (info.first.venta * (1 - (d["descuento"].to_f/100)))
          @preciofinal = @preciofinal + (info.first.venta * (1 - (d["descuento"].to_f/100)))

        end
      end
      
    end

    @totalcosto= 0
    @totalcosto = (@preciofinal*(1+(@iva.to_f/100).round(2))).round(2)

  end
  # PATCH/PUT /venta/1
  # PATCH/PUT /venta/1.json
  def update
    obtener_datos()
    @cliente = params[:cliente] + " " +params[:cliente_apellido]
    respond_to do |format|
      if @ventum.update(cliente: @cliente, clave:@clave, fecha:@fecha, iva:@iva)
        @detail.each do |x|
          x.destroy
        end
        salvar()
        format.html { redirect_to @ventum, notice: 'Venta actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @ventum }
      else
        format.html { render :edit }
        format.json { render json: @ventum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venta/1
  # DELETE /venta/1.json
  def destroy
    @ventum.destroy
    respond_to do |format|
      format.html { redirect_to venta_url, notice: 'Se ha eliminado la venta exitosamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ventum
      @ventum = Ventum.find(params[:id])
      @detail = Detail.where("venta_id = ?",@ventum.id)
      @rols = Rol.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ventum_params
      params.require(:ventum).permit(:cliente, :clave, :fecha, :iva)
    end
end
