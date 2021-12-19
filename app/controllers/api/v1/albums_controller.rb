module Api
  module V1
    class AlbumsController < ApplicationController

      # GET /api/v1/albums/:id/songs
      def song
        @album = Album.find(params[:id])
        return @album
      end
    end
  end
end