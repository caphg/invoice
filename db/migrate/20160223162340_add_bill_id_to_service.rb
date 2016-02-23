class AddBillIdToService < ActiveRecord::Migration
  def change
    add_column :services, :bill_id, :integer
  end
end
