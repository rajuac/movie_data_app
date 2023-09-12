class CreateMovieData < ActiveRecord::Migration[7.0]
  def change
    create_table :movie_data do |t|
      t.string :key_word
      t.json :payload
      t.datetime :search_time
      t.integer :cache_count ,default: 0
      t.timestamps
    end
  end
end
