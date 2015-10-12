json.array!(@rols) do |rol|
  json.extract! rol, :id, :nombre, :precio_hora
  json.url rol_url(rol, format: :json)
end
