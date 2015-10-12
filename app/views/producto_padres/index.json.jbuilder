json.array!(@producto_padres) do |producto_padre|
  json.extract! producto_padre, :id, :nombre, :descripcion
  json.url producto_padre_url(producto_padre, format: :json)
end
