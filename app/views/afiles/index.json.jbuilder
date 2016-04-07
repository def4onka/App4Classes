json.array!(@afiles) do |afile|
  json.extract! afile, :id, :document_id, :source, :path
  json.url afile_url(afile, format: :json)
end
