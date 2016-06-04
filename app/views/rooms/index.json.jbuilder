json.array!(@rooms) do |room|
  json.extract! room, :id, :name, :height, :width
  json.url room_url(room, format: :json)
end
