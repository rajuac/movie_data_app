# frozen_string_literal: true

class MovieJob < ApplicationJob
  queue_as :default

  def perform(params)
    MovieDataCreator.new(params).call
  end
end
