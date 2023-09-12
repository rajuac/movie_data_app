# frozen_string_literal: true

class MovieDataCreator
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    create_movie_data
  end

  private

  def create_movie_data
    MovieDatum.create(key_word: params[:query], payload: params[:json_data], search_time: Time.now)
  end
end
