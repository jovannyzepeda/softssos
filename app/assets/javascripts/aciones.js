function enviar(id , nombre, costo){
	var distribuidor = $("#flip-min").val();
	if(distribuidor=="distribuidorno")
		$('#elements').append( 	'<div class="col-md-12"><input type="hidden" value="'+costo+'" id="respaldo'+id+'">'+
			'<div class="col-md-5">'+
		'<input type="text"  id="'+id+'" name="data[][nombre]" value="'+nombre+'" class="alert alert-success" style="width:100%"></div>'+
		'<div class="col-md-2"><input type="number" min="0" max="100" id="'+id+'descuento" name="data[][descuento]" step="any" placeholder="% Descuento" class="alert cien"onchange="actualizar('+id+')"></div>'+
		'<div class="col-md-5"><input class="alert alert-info" id="cos'+id+'" style="width:40%; float:left" value="'+costo+'" disabled="disabled">'+
		'<input type="number" id="'+id+'num" name="data[][cantidad]"  value="1" min="1" class="alert alert-danger" style="width:40%" onchange="actualizar('+id+')"">'+
		'<button class="red float_right" onclick="eliminar('+id+')" id="'+id+'">x</button> </div></div>' );  
	else
		$('#elements').append( 	'<div class="col-md-12"><input type="hidden" value="'+costo+'" id="respaldo'+id+'">'+
			'<div class="col-md-3">'+
		'<input type="text"  id="'+id+'" name="data[][nombre]" value="'+nombre+'" class="alert alert-success" style="width:100%"></div>'+
		'<div class="col-md-2"><input type="number" min="0" max="100" id="'+id+'descuento" name="data[][descuento]" step="any" placeholder="% Descuento" class="alert cien"onchange="actualizar('+id+')"></div>'+
		'<div class="col-md-2"><input type="number" min="0" max="100" id="'+id+'descuentodistribuidor" name="data[][descuentodistribuidor]" step="any" placeholder="% Descuento" class="alert cien"onchange="actualizar('+id+')"></div>'+
		'<div class="col-md-5"><input class="alert alert-info" id="cos'+id+'" style="width:40%; float:left" value="'+costo+'" disabled="disabled">'+
		'<input type="number" id="'+id+'num" name="data[][cantidad]"  value="1" min="1" class="alert alert-danger" style="width:40%" onchange="actualizar('+id+')"">'+
		'<button class="red float_right" onclick="eliminar('+id+')" id="'+id+'">x</button> </div></div>' );  
}

function eliminar(id){$("#"+id+"descuento").remove();$("#"+id+"descuentodistribuidor").remove();$("input#"+id).remove();$("#cos"+id).remove();$("button#"+id).remove(); $("#respaldo"+id).remove();$("#"+id+"num").remove();}function cargar(){$('#elements').empty();$("#tiempos").val("");$("input#nom").val("");$("input#ape").val("");$("button.ui-grid-a").removeClass("active");}

function actualizar(id){
	var distribuidor = $("#flip-min").val();
	var des = $("#"+id+"descuento").val();
	var x = $("#"+id+"num");
	var costo = $("#respaldo"+id);
	var modifi = $("#cos"+id);
	if(distribuidor == "distribuidorsi"){
		var dis = $("#"+id+"descuentodistribuidor").val();
		modifi.val((((x.val()*costo.val())*(1-des/100))* (1-dis/100)).toFixed(2));
	}
	else
		modifi.val(((x.val()*costo.val())*(1-des/100)).toFixed(2));
}
function validarval(){
	if($("#select-based-flipswitch").val() != "No"){
		$("#desaparecetime").removeClass("desaparecetime");
		if($("#select-based-flipswitch").val() == "Remotamente"){
			$("#costoinstalar").val("550");
		}else{
			$("#costoinstalar").val("650");
		}
	}else{
		$("#desaparecetime").addClass("desaparecetime");
	}
}
function reload(){
	jQuery.mobile.changePage(window.location.reload(), {
          allowSamePageTransition: true,
          transition: 'none',
          reloadPage: true
        });
}