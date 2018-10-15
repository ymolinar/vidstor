class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.date :release_date
      t.integer :duration, default: 1
      t.string :country, default: 'usa'
      t.text :synopsis
      t.string :imdb_code
      t.string :youtube_trailer_code
      t.string :classification, default: 'G'
      t.decimal :loan_price, precision: 4, scale: 2, default: 5.00

      t.timestamps
    end
  end
end
