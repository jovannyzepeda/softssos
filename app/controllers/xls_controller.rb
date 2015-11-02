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
			0.upto @worksheet.last_row_index do |index|
			  row = @worksheet.row(index)
			  data = "%"<<row[1].to_s<<"%"
			  padre = ProductoPadre.where('clave like ?',data)
			  if padre.present?
				  actualizar = ''
				  actualizar = Producto.find_by(clave: row[2]);
				  if actualizar.present?
						actualizar.update(nombre: row[3], precio: row[4], venta: row[5], instalacion: row[6], instalacionpreencial: row[7], descripcion: row[8], producto_padre_id: padre.first.id)
				  	else
				  		guardar = Producto.new
						guardar.clave = row[2]
						guardar.nombre = row[3]
						guardar.precio = row[4]
						guardar.venta = row[5]
						guardar.instalacion = row[6]
						guardar.instalacionpreencial = row[7]
						guardar.descripcion = row[8]
						guardar.producto_padre_id = padre.first.id
						guardar.save
				  end
				  
				end
			end
			if File.exist?(path)
			    resultado = File.delete(path);
			end
		end
  end
end
