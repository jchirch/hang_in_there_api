class Api::V1::PostersController < ApplicationController

    def index
        # render json: Poster.all
        render json: PosterSerializer.render_all_posters(Poster.all)
    end

    def show
      poster = Poster.find(params[:id])
      render json: PosterSerializer.render_poster(poster)
    end

    def create
      poster = Poster.create(poster_params)
      render json: PosterSerializer.render_poster(poster)
    end

    def update
        poster = Poster.find(params[:id])
        poster.update!(poster_params)
        render json: PosterSerializer.render_poster(poster)
    end

    private

    def poster_params
        params.permit(:name, :description, :price, :year, :vintage, :img_url)
    end
end