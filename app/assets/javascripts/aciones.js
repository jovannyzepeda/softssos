function enviar(id , nombre, costo, preciocompra){
	var distribuidor = $("#flip-min").val();
	if(distribuidor=="distribuidorno")
		$('#elements').append( 	
			'<div class="col-md-12" id="fiel'+id+'">'+
				'<div class="col-md-3">'+
					'<label class="menorvisibles">Nombre</label>'+
					'<input type="text"  id="'+id+'" name="data[][nombre]" value="'+nombre+'" class="alert alert-success">'+
				'</div>'+
				'<div class="col-md-2">'+
					'<input type="hidden" id="real'+id+'" name="data[][costo]" value="'+preciocompra+'">'+
					'<label class="menorvisibles">Costo S/IVA</label>'+
					'<input type="number" class="alert" name="data[][precio]" step="any" value="'+costo+'" id="respaldo'+id+'" onchange="actualizar('+id+')">'+
				'</div>'+
				'<div class="col-md-2">'+
					'<label class="menorvisibles">Descuento %</label>'+
					'<input type="number" min="0" max="100" id="'+id+'descuento" name="data[][descuento]" step="any" placeholder="% Descuento" class="alert  cien"onchange=" actualizar('+id+')">'+
				'</div>'+
				'<div class="col-md-2">'+
					'<label class="menorvisibles">Total</label>'+
					'<input class="alert alert-info" id="cos'+id+'" name="data[][total]" value="'+costo+'" >'+
				'</div>'+
				'<div class="col-md-2">'+
					'<label class="menorvisibles">Cantidad</label>'+
					'<input type="number" id="'+id+'num" name="data[][cantidad]"  value="1" min="1" class="alert alert-danger" onchange="actualizar('+id+')"">'+
				'</div>'+
				'<div class="col-md-1">'+
					'<button class="red" onclick="eliminar('+id+')" id="'+id+'">x</button>'+
				'</div>'+
			'</div>' );  
	else
		$('#elements').append(
		'<div class="col-md-12" id="fiel'+id+'">'+
				'<div class="col-md-3">'+
					'<label class="menorvisibles">Nombre</label>'+
					'<input type="text"  id="'+id+'" name="data[][nombre]" value="'+nombre+'" class="alert alert-success">'+
				'</div>'+
				'<div class="col-md-2">'+
					'<input type="hidden" id="real'+id+'" name="data[][costo]" value="'+preciocompra+'">'+
					'<label class="menorvisibles">Costo S/IVA</label>'+
					'<input type="number" class="alert" name="data[][precio]" step="any" value="'+costo+'" id="respaldo'+id+'" onchange="actualizar('+id+')">'+
				'</div>'+
				'<div class="col-md-2">'+
					'<label class="menorvisibles">Descuento %</label>'+
					'<input type="number" min="0" max="100" id="'+id+'descuento" name="data[][descuento]" step="any" placeholder="% Descuento"  style="width:50%!important; float:left" class="alert  cien"onchange=" actualizar('+id+')">'+
					'<input type="number" min="0" max="100" id="'+id+'descuentodistribuidor" name="data[][descuentodistribuidor]" step="any" style="width:50%!important; float:left;" placeholder="% Descuento" class="alert cien"onchange="actualizar('+id+')">'+
				'</div>'+
				'<div class="col-md-2">'+
					'<label class="menorvisibles">Total</label>'+
					'<input class="alert alert-info" id="cos'+id+'" name="data[][total]" value="'+costo+'" >'+
				'</div>'+
				'<div class="col-md-2">'+
					'<label class="menorvisibles">Cantidad</label>'+
					'<input type="number" id="'+id+'num" name="data[][cantidad]"  value="1" min="1" class="alert alert-danger" onchange="actualizar('+id+')"">'+
				'</div>'+
				'<div class="col-md-1">'+
					'<button class="red" onclick="eliminar('+id+')" id="'+id+'">x</button>'+
				'</div>'+
			'</div>'  );  
}

function eliminar(id){$("#fiel"+id).remove();}function cargar(){$('#elements').empty();$("#tiempos").val("");$("input#nom").val("");$("input#ape").val("");$("button.ui-grid-a").removeClass("active");}

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

