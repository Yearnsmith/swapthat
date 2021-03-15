json.extract! listing, :id, :title, :description, :seller_id, :locked, :created_at, :updated_at
json.url listing_url(listing, format: :json)
