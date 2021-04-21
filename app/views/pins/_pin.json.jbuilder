json.extract! pin, :id, :name, :address, :latitude, :longitude, :category, :privacy, :cover_image_description,
              :created_at, :updated_at
json.url pin_url(pin, format: :json)
