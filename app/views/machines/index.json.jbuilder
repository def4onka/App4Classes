json.array!(@machines) do |machine|
  json.extract! machine, :id, :room_id, :left, :top, :name
  json.url machine_url(machine, format: :json)
end
