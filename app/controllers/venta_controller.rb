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
      #estimacion
      format.xlsx
      #pdf cotizacion
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
            pdf.text "Servicios/Productos Cotizados\n"
            @detail.each do |x|
              if x.producto == "Presencialmente" || x.producto == "Remotamente"
                pdf.text "° Asesoría y soporte técnico vía " + x.producto
              else
                pdf.text "° "+x.producto
              end
            end
            pdf.text "\n\n"
            if @ventum.distribuidor == "distribuidorsi"
              table_data = [['#', 'Artículo / Descripción', 'Cant', 'Precio unitario', 'Impuesto', 'Descuento','descuento proveedor','Total']]
              @detail.each do |x|
                i = i + 1
                table_data += [[i, x.producto, x.cantidad,x.precioventa,@ventum.iva,x.descuento,x.descuentoproveedor,x.total]]
              end
            else
              table_data = [['#', 'Artículo / Descripción', 'Cant', 'Precio unitario', 'Impuesto', 'Descuento','Total']]
              @detail.each do |x|
                i = i + 1
                table_data += [[i, x.producto, x.cantidad,x.precioventa,@ventum.iva,x.descuento,x.total]]
              end
            end
          pdf.table(table_data,:width => 540)
          iva = (@ventum.subtotal * ((@ventum.iva.to_f)/100)).round(2)
          if@ventum.descuentogeneral.present?
            totaladicional = ((iva + @ventum.subtotal)*((@ventum.descuentogeneral/100).to_f)).round(2)
            pdf.text "\nSub total: #{@ventum.subtotal}\n Impuesto de ventas (#{@ventum.iva.to_i}%): #{iva}\nDescuento(#{@ventum.descuentogeneral}%): #{totaladicional} \n<b>Total: #{@ventum.total}</b>", :align => :right , :inline_format => true
          else
            pdf.text "\nSub total: #{@ventum.subtotal}\n Impuesto de ventas (#{@ventum.iva.to_i}%): #{iva}\n <b>Total: #{@ventum.total}</b>", :align => :right , :inline_format => true
          end
          pdf.text "\n\nINFORMACIÓN DE PAGO: SOS Software S.A. de C.V.\n\n
                  BANCO BANORTE: No. Cuenta: 0239431716; CLABE: 072320002394317160\n\n
                    RFC: SOF1406233F5\n\n\n", :inline_format => true, :align => :justify
          pdf.text "\n\nEstimado cliente, es muy importante validar que cuentas con el suficiente equipo para generar la instalación de nuestros productos o servicios, para ello se recomienda consultar nustro detalle de requerimientos mínimos en el enlace: \nhttp://sos-soft.com/requerimientos.pdf\n\nTe invitamos a consultar los terminos y condiciones de nuestro servicio en el siguiente enlace \nhttp://sos-soft.com/Politicassos.pdf", :inline_format => true
          send_data pdf.render, filename: 'Cotización.pdf', type: 'application/pdf' 
      end
      #PDF carta de aceptacion
      format.adicional do
       
            pdf = Prawn::Document.new
            sos = "#{Rails.root}/public/images/pdf/sos.png" 
            pdf.image sos, :position => :left, :width => 150   
            pdf.draw_text "SOS Software S.A. de C.V.", :at => [300,700]
            pdf.draw_text "Medrano 710; General Real", :at => [300,680]
            pdf.draw_text "Teléfono: (0133) 3617-2968", :at => [300,660]
            pdf.draw_text "E-mail: info@sos-soft.com", :at => [300,640]
            pdf.text "________________________________________________________________________________"
            pdf.text "<b><font size='24'>\nCarta de agradecimiento\n\n</font></b>", :inline_format => true, :align => :justify
            pdf.text "Estimado/a #{@ventum.cliente}\n\nSOS Software se complace en dirigirse hacia usted para saludarlo y aprovechar la oportunidad para agradecerle profundamente la preferencia que ha mostrado por nuestros productos y servicio. Su apoyo nos hace cada día mejores personas y aumenta nuestro compromiso con su satisfacción a través de lo que le ofrecemos.\n\nEsperamos que su confianza en nosotros se incremente con cada adquisición de nuestros productos.\n\nQueremos comunicarle también que estamos complacidos de servirlo y ofrecerle productos de mejor calidad cada vez.\nEsperamos satisfacer sus necesidades con productos de primera calidad y a través del mejor servicio en el mercado.", :inline_format => true, :align => :justify
            pdf.text "\n\nSe solicita amablemente enviar un correo con el asunto: Carta de aceptación y con el siguiente contenido:", :inline_format => true, :align => :justify
            pdf.text "________________________________________________________________________________"
            pdf.text "\n\nSOS Software confirma haber entregado los siguientes productos/servicios:\n\n", :inline_format => true   
            @detail.each do |x|
           
              if x.producto == "Presencialmente" || x.producto == "Remotamente"
                pdf.text "° "+x.cantidad.to_s+ " Asesoría y soporte técnico vía " + x.producto
              else
                pdf.text "° "+x.cantidad.to_s+" "+x.producto
              end
            end
            pdf.text "\n\nMuchas gracias por tu tiempo y recuerda que nuestra misión es ayudarte a administrar y controlar mejor tu negocio de una manera automatizada.", :inline_format => true , :align => :justify
            pdf.text "\n\nSOS Software SA de CV", :inline_format => :true, :align =>:justify 
            pdf.text "\nDesarrollamos tus ideas", :inline_format => :true, :align =>:justify 
              
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
    @ventum = current_user.ventum.new(cliente:@cliente, clave:@clave, fecha:@fecha, iva:@iva, subtotal:@preciofinal ,total:@totalcosto, descuentogeneral: @descglobal, distribuidor: @distribuidor, status: "En proceso")
    respond_to do |format|
        if(@ventum.save)
          salvar()
          format.html { redirect_to @ventum, notice: 'Venta almacenada exitosamente!.' }
        else
          format.html { redirect_to eventos_path, notice: 'Fallo el almacenamiento de la venta.' }
        end
       
    end
  end
  #salva informacion de detalle de prouctos
  def salvar
    i = 0
    if @data.present?
      @data.each do |detalle|
        @detalle = Detail.new(producto: detalle["nombre"], cantidad: detalle["cantidad"] , precio: detalle["costo"], precioventa: detalle["precio"], total: detalle["total"] , descuento: detalle["descuento"], descuentoproveedor: detalle["descuentodistribuidor"], ventum_id: @ventum.id )
        @detalle.save
        i = i + 1
      end
    end
    if @tiempo_instalar.present?
      @detalle = Detail.new(producto: @activacion, cantidad: @tiempo_instalar , precio: @precioinstalar, precioventa: @precioinstalar, total: @costo_instalar, descuento:@descuentoinstalar , venta_id: @ventum.id )
      @detalle.save
    end
  end
  def obtener_datos
    #recuperar parametros necesarios del formulario
    @data = params[:data]  #datos productos
    #datos deformulario base
      @fecha = params[:fecha]
      @clave = params[:clave]
      @iva = params[:iva]
      @cliente = params[:cliente] + " " +params[:cliente_apellido]
      @descglobal  = params[:descuentogeneral].to_i
      @global = params[:descuentogeneral].to_f
      @global = (1-(@global/100).to_f).round(2)#descento convrtido en decimal aplicable 
      @distribuidor = params[:distribuidor]
    #fin datos base

      @activacion = params[:instalacion]
      #variables requeridas para medir tiempos de instalacion en caso de aplicar
      @precioinstalar = 0
      horas = 0 
      @descuentoinstalar = 0
      @preciofinal = 0
      #calcular variables en tiempo de instalacion
      if @activacion != "No"
        horas = params[:tiempoinstalar]
        @precioinstalar = params[:costoinstalar].to_f
        @descuentoinstalar = params[:descuentoinstalar].to_f
        adicionaldescuento = 1 - (@descuentoinstalar/100).to_f
        adicionaldescuento = 1 - (@descuentoinstalar/100).to_f#variable de descuento modificada para uso directo
        @tiempo_instalar = (horas.to_f/60).round(2)
        @costo_instalar = (@tiempo_instalar * @precioinstalar) * adicionaldescuento
        @preciofinal = @preciofinal + @costo_instalar
      end
      #calcular subtotal
      unless @data.blank?
        @data.each do |d|
          @preciofinal = @preciofinal + d["total"].to_f
        end
      end
      #calcular total
      @totalcosto = 0
      @totalcosto = (@preciofinal*(1+(@iva.to_f/100))).round(2)
      @totalcosto = (@totalcosto * @global).round(2)

  end
  # PATCH/PUT /venta/1
  # PATCH/PUT /venta/1.json
  def update
    obtener_datos()
    @status = params[:statusproyect]
    @cliente = params[:cliente] + " " +params[:cliente_apellido]
    respond_to do |format|
      if @ventum.update(cliente: @cliente, clave:@clave, fecha:@fecha, iva:@iva,subtotal:@preciofinal ,total:@totalcosto, descuentogeneral: @descglobal , distribuidor: @distribuidor, status: @status)
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
      @detail = Detail.where("ventum_id = ?",@ventum.id)
      @rols = Rol.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ventum_params
      params.require(:ventum).permit(:cliente, :clave, :fecha, :iva)
    end
end
