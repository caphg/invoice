json.array!(@services) do |service|
  json.extract! service, :id, :name, :description, :amount, :currency, :quantity
  json.url service_url(service, format: :json)
end
