class AddNameToBill < ActiveRecord::Migration
  def change
    add_column :bills, :name, :string
  end
end
