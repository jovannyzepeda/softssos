function enviar(id , nombre){$('#elements').append( 	'<input type="text"  id="'+id+'" name="data[][nombre]" value="'+nombre+'" class="alert alert-success" style="width:85%" readondly>	<input type="number" id="'+id+'num" name="data[][cantidad]"  value="1" min="1" class="alert alert-danger" style="width:10%">	<button class="red float_right" onclick="eliminar('+id+')" id="'+id+'">x</button> ' );  }function eliminar(id){$("input#"+id).remove();$("button#"+id).remove(); $("#"+id+"num").remove();}function cargar(){$('#elements').empty();}
