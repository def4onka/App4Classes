json.array!(@presentations) do |presentation|
  json.extract! presentation, :id, :document_id, :user_id, :comment, :groups, :last_open_slide, :auto_open
  json.url presentation_url(presentation, format: :json)
end
