class Api::V1::PostersController < ApplicationController

  def index
    # render json: PosterSerializer.render_all_posters(Poster.all)
    posters = Poster.all
    render json: PosterSerializer.new(posters)
  end

	def show
		poster = Poster.find(params[:id])
		render json: PosterSerializer.new(poster)
	#   render json: PosterSerializer.render_poster(poster)
	end

	def update
		poster = Poster.find(params[:id])
		render json: PosterSerializer.new(poster)
		poster.update!(poster)

		# poster = Poster.find(params[:id])
		# poster.update!(poster_params)
		# render json: PosterSerializer.render_poster(poster)
	end

	def destroy
		render json: Poster.delete(params[:id])
		head :no_content
	end

	private

	def poster_params
		params.permit(:name, :description, :price, :year, :vintage, :img_url)
	end
end