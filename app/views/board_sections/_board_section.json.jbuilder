json.extract! board_section, :id, :name, :board_id, :pins_count, :slug, :position, :created_at, :updated_at
json.url board_section_url(board_section, format: :json)
