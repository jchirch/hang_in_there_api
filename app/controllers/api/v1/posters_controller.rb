class Api::V1::PostersController < ApplicationController

  def index
    sort = params[:sort]
    name = params[:name]
    if params[:sort]
      posters = Poster.sort_results(sort)
    elsif params[:name]
      posters = Poster.filter_name(name)
    else
      posters = Poster.all
    end
		options = {}
		options[:meta] = { count: Poster.count }
    render json: PosterSerializer.new(posters, options)

  end

	def show
		poster = Poster.find(params[:id])
		render json: PosterSerializer.new(poster)
	end

	def create
		poster = Poster.create(poster_params)
		render json: PosterSerializer.new(poster)
	end

	def update
		poster = Poster.find(params[:id])
		poster.update!(poster_params)
		render json: PosterSerializer.new(poster)
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

