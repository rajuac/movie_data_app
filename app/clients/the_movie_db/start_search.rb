# frozen_string_literal: true

module TheMovieDb
  class StartSearch < Base
    attr_reader :params

    def initialize(params)
      @params = params
    end

    def call
      movie_data_api
    end

    private

    def movie_data_api
      HTTParty.get("#{url}search/movie?query=#{params[:query]}&include_adult=false&language=en-US&page=1",
                   headers: { 'Authorization' => authorization })
    rescue StandardError => e
      { message: e.message, status: 400 }
    end
  end
end
