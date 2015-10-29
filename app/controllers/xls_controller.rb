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
			  data = "%"<<row[4].to_s<<"%"
			  padre = ProductoPadre.where('nombre like ?',data)
			  actualizar = ''
			  actualizar = Producto.find_by(clave: row[0]);
			  if actualizar.present?
					actualizar.update(nombre: row[1], precio: row[2], venta: row[3], instalacion: row[5], instalacionpreencial: row[6], descripcion: row[7], producto_padre_id: padre.first.id)
			  	else
			  		guardar = Producto.new
					guardar.clave = row[0]
					guardar.nombre = row[1]
					guardar.precio = row[2]
					guardar.venta = row[3]
					guardar.instalacion = row[5]
					guardar.instalacionpreencial = row[6]
					guardar.descripcion = row[7]
					guardar.producto_padre_id = padre.first.id
					guardar.save
			  end
			  
			end
			if File.exist?(path)
			    resultado = File.delete(path);
			end
		end
  end
end
