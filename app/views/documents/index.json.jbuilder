json.array!(@documents) do |document|
  json.extract! document, :id, :user_id, :comment, :material_id
  json.url document_url(document, format: :json)
end
