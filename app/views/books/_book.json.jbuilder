json.extract! book, :id, :name, :summary, :created_at, :updated_at
json.url book_url(book, format: :json)
