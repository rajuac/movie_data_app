# frozen_string_literal: true

module TheMovieDb
  class Base
    def url
      Rails.application.secrets.movie_db_url
    end

    def authorization
      "Bearer #{Rails.application.secrets.movie_db_api_token}"
    end
  end
end
