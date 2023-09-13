# frozen_string_literal: true

class MovieDatum < ApplicationRecord
  validates :key_word, presence: true
  validates :payload, presence: true
end
