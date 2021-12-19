Rails.application.routes.draw do

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do

      get "/artists", to: "artists#index"
      get "/artists/:id/albums", to: "artists#album"
      get "/albums/:id/songs", to: "albums#song"

    end
  end

end
