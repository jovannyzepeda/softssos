function enviar(id , nombre, costo){$('#elements').append( 	'<div class="col-md-12"><div class="col-md-7"><input type="text"  id="'+id+'" name="data[][nombre]" value="'+nombre+'" class="alert alert-success" style="width:100%"></div><div class="col-md-5"><input class="alert alert-info" id="cos'+id+'" style="width:40%; float:left" value="'+costo+'" disabled="disabled"><input type="number" id="'+id+'num" name="data[][cantidad]"  value="1" min="1" class="alert alert-danger" style="width:40%" onchange="actualizar('+id+')"">	<button class="red float_right" onclick="eliminar('+id+')" id="'+id+'">x</button> </div></div>' );  }function eliminar(id){$("input#"+id).remove();$("button#"+id).remove(); $("#"+id+"num").remove();}function cargar(){$('#elements').empty();$("#tiempos").val("");$("input#nom").val("");$("input#ape").val("");$("button.ui-grid-a").removeClass("active");$("#desaparecetime").removeClass("desaparecetime");}
function actualizar(id){
	var x = $("#"+id+"num");
	var costo = $("#cos"+id);
	costo.val(x.val()*costo.val());
}
function validarval(){
	if($("#select-based-flipswitch").val() != "No"){
		$("#desaparecetime").removeClass("desaparecetime");
	}else{
		$("#desaparecetime").addClass("desaparecetime");
	}
}