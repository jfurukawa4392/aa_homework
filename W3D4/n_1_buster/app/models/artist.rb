class Artist < ActiveRecord::Base
  has_many(
    :albums,
    class_name: "Album",
    foreign_key: :artist_id,
    primary_key: :id
  )

  def n_plus_one_tracks
    albums = self.albums
    tracks_count = {}
    albums.each do |album|
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
  end

  def better_tracks_query
    # TODO: your code here
    albums = self.albums.includes(:tracks)
    track_count = {}
    albums.each do |album|
      track_count[album.title] = album.tracks.length
    end

    track_count
  end
end
