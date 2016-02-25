class AddDateToBill < ActiveRecord::Migration
  def change
    add_column :bills, :date, :datetime
  end
end
