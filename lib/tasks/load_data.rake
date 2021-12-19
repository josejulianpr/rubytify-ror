namespace :load_data do
  desc "Load information of Artists"
  task :load_data_artists => :environment do
    require 'rspotify'
    require 'yaml'

    Song.delete_all
    Album.delete_all
    ArtistGenre.delete_all
    Genre.delete_all
    Artist.delete_all

    puts "Starting data load"

    artists_list = YAML.load_file('artists.yml')
    artists_list['artists'].each { |i|

      #Find artist information
      artists = RSpotify::Artist.search(i.to_s)

      #Get information
      artist_information = artists.first

      unless artist_information.nil?
        create_artist(artist_information)
      end
    }

    puts "Finishing data load"
  end
end

def create_artist(artist_information)
  artist = build_artist(artist_information)

  artist_information.genres.each { |i|
    genre = Genre.find_by_name(i)

    unless genre.present?
      genre = Genre.create(name: i)
    end

    ArtistGenre.create(artist: artist, genre: genre)
  }

  #Get Albums
  albums = artist_information.albums
  albums.each { |album_info|

    album = build_album(album_info, artist)

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
end

def build_artist(artist_information)
  Artist.create(
    name: artist_information.name,
    image: !artist_information.images.empty? ? artist_information.images.first['url'] : "",
    popularity: artist_information.popularity,
    spotify_url: artist_information.external_urls['spotify'],
    spotify_id: artist_information.id
  )
end

def build_album(album_info, artist)
  Album.create(
    name: album_info.name,
    image: !album_info.images.empty? ? album_info.images.first['url'] : "",
    spotify_url: album_info.external_urls['spotify'],
    total_tracks: album_info.total_tracks,
    spotify_id: album_info.id,
    artist: artist
  )
end
