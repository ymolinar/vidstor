class AddStatusToLoans < ActiveRecord::Migration[5.2]
  def change
    add_column :loans, :status, :integer, default: 0
    add_index :loans, :status
  end
end
