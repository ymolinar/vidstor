class AddIndexToMovies < ActiveRecord::Migration[5.2]
  def change
    add_index :movies, :title, unique: true
  end
end
