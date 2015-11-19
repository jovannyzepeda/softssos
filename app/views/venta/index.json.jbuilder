json.array!(@venta) do |ventum|
  json.extract! ventum, :id, :cliente, :clave, :fecha, :iva
  json.url ventum_url(ventum, format: :json)
end
