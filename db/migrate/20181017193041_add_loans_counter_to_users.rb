class AddLoansCounterToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :loans_counter, :integer, default: 0
  end
end
