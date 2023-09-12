# frozen_string_literal: true

class MoviesController < ApplicationController
  def search
    return @movies = [] if params[:query].nil?

    movie_data = MovieSearcher.new(params).call
    p movie_data
    if movie_data[:status] == 200
      @movies = movie_data[:message]['results']
      @movies = @movies.paginate(page: params[:page], per_page: 20)

      render json: @movies
    else
      flash['notice'] = movie_data[:message]
    end
  end
end
