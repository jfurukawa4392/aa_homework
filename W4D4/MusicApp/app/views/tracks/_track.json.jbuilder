json.extract! track, :id, :album_id, :name, :track_type, :lyrics, :created_at, :updated_at
json.url track_url(track, format: :json)