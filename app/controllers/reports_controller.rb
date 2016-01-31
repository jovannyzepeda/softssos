class ReportsController < ApplicationController
  def index
  end
  def create
  	@inicio = params[:inicio]
  	@fin  = params[:fin]
  	@datos = Ventum.where("fecha >= ? and fecha <= ?", @inicio, @fin)
  	respond_to do |format|
  		format.html do
  		end
  		format.pdf do
	        pdf = Prawn::Document.new
	        sos = "#{Rails.root}/public/images/pdf/sos.png" 
        	pdf.image sos, :position => :left, :width => 100
        	pdf.draw_text "Reporte de proyectos", :at => [200,700], size: 30
        	pdf.text "\n\n"
          pdf.text "Fecha de Generación del Reporte: #{Time.now.year}-#{Time.now.month}-#{Time.now.day}\n"
	        pdf.text "Intervalo de reporte #{@inicio} - #{@fin}\n"
          pdf.text "Generado por #{current_user.email}\n"
          table_data = [['Nombre de Cliente', 'Fecha de inicio', 'Estado', 'Responsable']]
	        @datos.each do |x|
	        	if x.user.present?
	        		table_data += [[x.cliente, x.fecha, x.status ,x.user.email]]
	        	else
	        		table_data += [[x.cliente, x.fecha, x.status , "sin registro"]]
	        	end
	        end
          	pdf.table(table_data,:width => 540)
        	send_data pdf.render, filename: 'Reporte de proyectos.pdf'
      	end
  	end
  	#redirect_to reports_path
  end
end
