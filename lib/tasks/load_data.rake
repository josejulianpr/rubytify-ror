namespace :load_data do
  desc "Load information of Artists"
  task :load_data_artists => :environment do
    require 'rspotify'
    require 'yaml'

    puts "Hello World"
    artists_list = YAML.load_file('artists.yml')
    artists_list['artists'].each { |i|

      #Find artist information
      artists = RSpotify::Artist.search(i.to_s)

      #Get information
      arctic_monkeys = artists.first
      arctic_monkeys.name
      arctic_monkeys.images.first['url']
      arctic_monkeys.genres
      arctic_monkeys.popularity
      arctic_monkeys.external_urls['spotify']
      arctic_monkeys.id

      #Get Albums
      albums = arctic_monkeys.albums
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


      puts arctic_monkeys
    }

  end
end