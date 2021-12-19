namespace :load_data do
  desc "Load information of Artists"
  task :load_data_artists => :environment do
    require 'rspotify'
    require 'yaml'

    Song.delete_all
    Album.delete_all
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
      albums.each { |album_info|

        album = Album.create(
          name: album_info.name,
          image: album_info.images.first['url'],
          spotify_url: album_info.external_urls['spotify'],
          total_tracks: album_info.total_tracks,
          spotify_id: album_info.id,
          artist: artist
        )

        songs = album_info.tracks
        songs.each { |song_info|

          Song.create(
            name: song_info.name,
            spotify_url: song_info.external_urls['spotify'],
            preview_url: song_info.preview_url,
            duration_ms: song_info.duration_ms,
            explicit: song_info.explicit,
            spotify_id: song_info.id,
            album: album
          )
        }
      }

      puts "Artist \"" + artist.name + "\" load"
    }

    puts "Finishing data load"
  end
end