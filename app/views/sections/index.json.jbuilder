json.array!(@sections) do |section|
  json.extract! section, :id, :document_id, :source, :position
  json.url section_url(section, format: :json)
end
