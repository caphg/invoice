class AddClientIdToBill < ActiveRecord::Migration
  def change
    add_column :bills, :client_id, :integer
  end
end
