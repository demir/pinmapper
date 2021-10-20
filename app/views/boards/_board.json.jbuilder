json.extract! board, :id, :name, :privacy, :created_at, :updated_at
json.url board_url(board, format: :json)
