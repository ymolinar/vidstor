class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.datetime :expire_at, null: false
      t.timestamps
    end

    create_join_table :loans, :movies do |t|
      t.index :loan_id
      t.index :movie_id
    end
  end
end
