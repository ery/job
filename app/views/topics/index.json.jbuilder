json.array!(@topics) do |topic|
  json.extract! topic, :id, :title, :url, :memo
  json.url topic_url(topic, format: :json)
end
