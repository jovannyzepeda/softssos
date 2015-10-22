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
    				pdf.draw_text "#{@cliente}", :at => [300,600]
    				pdf.text "________________________________________________________________________________"
    				pdf.text "<b><font size='24'>\nCotización\n</font></b>", :inline_format => true, :align => :center
    				t = Time.now
    				total = 0
    				i = -1
    				pdf.text "Girada el: #{t.strftime('%d/%m/%Y')}\n\n\n\n\n ", :align => :right , :inline_format => true
	          		table_data = [['#', 'Artículo / Descripción', 'Cant', 'Unidades', 'Precio unitario', 'Impuesto', 'Total']] + 
	          			@object.map do |product|
	          				i = i + 1
	          				total = total + (product[0].precio * @cant[i].to_i)
      						[product[0].id, product[0].nombre, @cant[i], "",product[0].precio,"16%",product[0].precio*@cant[i].to_i]
      						
      						
  						end
    				pdf.table(table_data,:width => 540)
    				iva = total * 0.16
    				pdf.text "\nSub total: #{total}\n Impuesto de ventas (16%): #{iva.round(2)}\n <b>Total: #{iva+total}</b>", :align => :right , :inline_format => true

    				pdf.text "\n\n\n\nINFORMACIÓN DE PAGO: SOS Software S.A. de C.V.\n\n
										BANCO BANORTE: No. Cuenta: 0239431716; CLABE: 072320002394317160\n\n
									    RFC: SOF1406233F5\n\n\n", :inline_format => true

					sos = "#{Rails.root}/public/images/pdf/soporte.png" 
    				pdf.image sos, :position => :center, :width => 600   


				send_data pdf.render, filename: 'Cotización.pdf', type: 'application/pdf'
	          		
	          end
	    end
	end
  end






end
