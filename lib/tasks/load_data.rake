namespace :load_data do
  desc "Load information of Artists"
  task :load_data_artists => :environment do
    require 'rspotify'
    require 'yaml'

    Artist.delete_all

    puts "Starting data load"

    artists_list = YAML.load_file('artists.yml')
    artists_list['artists'].each { |i|

      #Find artist information
      artists = RSpotify::Artist.search(i.to_s)

      #Get information
      artist_information = artists.first
      artist = Artist.create(
        name: artist_information.name,
        image: artist_information.images.first['url'],
        genres: artist_information.genres,
        popularity: artist_information.popularity,
        spotify_url: artist_information.external_urls['spotify'],
        spotify_id: artist_information.id
      )

      #Get Albums
      albums = artist_information.albums
      albums.each { |album|
        album.name
        album.images.first['url']
        album.external_urls['spotify']
        album.total_tracks
        album.id

        tracks = album.tracks
        tracks.each { |track|
          track.name
          track.external_urls['spotify']
          track.preview_url
          track.duration_ms
          track.explicit
          track.id
        }
      }

      puts "Artist \"" + artist.name + "\" load"
    }

    puts "Finishing data load"
  end
end