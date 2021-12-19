module Api
  module V1
    class ArtistsController < ApplicationController
      before_action :set_artist, only: [:show, :update, :destroy]

      # GET /artists
      def index
        @artists = Artist.order("popularity")
      end

      # GET /artists/:id/albums
      def album
        @artist = Artist.find(params[:id])
      end
    end

  end
end
