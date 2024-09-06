class Api::V1::PostersController < ApplicationController

  def index
    posters =
      if params[:sort]
        Poster.sort_results(params[:sort])  
      elsif params[:name]
        Poster.filter_name(params[:name])
      elsif params[:min_price]
         Poster.filter_min_price(params[:min_price])
      elsif params[:max_price]
        Poster.filter_max_price(params[:max_price])
      else
        Poster.all
      end
    
    render json: PosterSerializer.new(posters, meta:  { count: posters.count })
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

# Poster.where("price >= #{min_price}")