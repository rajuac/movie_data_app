# frozen_string_literal: true

class MovieSearcher
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    search_movie_data
  end

  private

  def search_movie_data
    movie_data = MovieDatum.where(key_word: params[:query]).last
    return { message: movie_data.payload, status: 200 } if movie_data.present? && movie_data_checked?(movie_data)

    response = TheMovieDb::StartSearch.new(params).call
    if response.code == 200
      json_string = response.body
      parsed_data = JSON.parse(json_string)
      params[:json_data] = parsed_data
      MovieJob.perform_later(params.to_enum.to_h)
      { message: parsed_data, status: 200 }
    else
      { message: 'Something went wrong! please try after some time', status: response.code }
    end
  end

  def movie_data_checked?(movie_data)
    search_time = movie_data.search_time
    time_difference = (Time.current - search_time).to_i

    return false unless time_difference < 120

    movie_data.increment!(:cache_count)
    true
  end
end
