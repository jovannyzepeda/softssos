json.array!(@productos) do |producto|
  json.extract! producto, :id, :nombre, :clave, :precio, :descripcion, :producto_padre_id
  json.url producto_url(producto, format: :json)
end
