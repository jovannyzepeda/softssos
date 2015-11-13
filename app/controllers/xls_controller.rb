class XlsController < ApplicationController
	Ruta_directorio_archivos = "public/";
    def subir_archivos
	  	if request.post? 
		    archivo = params[:archivo];
		    nombre = archivo.original_filename
		    directorio = Ruta_directorio_archivos;
		    extension = nombre.slice(nombre.rindex("."), nombre.length).downcase;
		    path = File.join(directorio, nombre);
		    resultado = File.open(path, "wb") { |f| f.write(archivo.read) };
			@workbook = Spreadsheet.open(path)
			@worksheet = @workbook.worksheet(0)
			@error = "Se presentaron errores con los siguientes productos\n"
			@active = 0;
			0.upto @worksheet.last_row_index do |index|
			  	row = @worksheet.row(index)
			  	if row[0] && row[1] && row[2] && row[3] && row[4] && row[5] && row[6] && row[7]
				  	data = "%"<<row[1].to_s<<"%"
				  	padre = ProductoPadre.where('clave like ?',data)
				  	if padre.present?
					  actualizar = ''
					  actualizar = Producto.find_by(clave: row[2]);
					else
						padre = ProductoPadre.new
						padre.nombre = row[0]
						padre.clave = row[1]
						padre.save
						padre = ProductoPadre.where('clave like ?',data)

					end
				  	if actualizar.present?
						if actualizar.update(nombre: row[3], precio: row[4], venta: row[5], instalacion: row[6], instalacionpreencial: row[7], descripcion: row[8], producto_padre_id: padre.first.id)
				  		else
				  			@active = 1
				  			@error = @error + row[3] + "\n"
				  		end
				  	else
				  		guardar = Producto.new
						guardar.clave = row[2]
						guardar.nombre = row[3].force_encoding("UTF-8")
						guardar.precio = row[4]
						guardar.venta = row[5]
						guardar.instalacion = row[6]
						guardar.instalacionpreencial = row[7]
						guardar.descripcion = row[8]
						guardar.producto_padre_id = padre.first.id
						if guardar.save
						else
							@active = 1
							@error = @error + guardar.nombre + "\n"
						end
				  	end
				end
			end
			if @active == 0
				@error = "Producutos almacenados correctamente"
			end
			if File.exist?(path)
			    resultado = File.delete(path);
			end
		end
	end
end
