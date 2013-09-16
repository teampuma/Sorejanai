json.array!(@articles) do |article|
  json.extract! article, :title
  json.url article_url(article, format: :json)
end