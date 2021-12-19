json.data @artists do |artist|
  json.id artist.id
  json.name artist.name
  json.image artist.image
  json.popularity artist.popularity
  json.spotify_url artist.spotify_url
end