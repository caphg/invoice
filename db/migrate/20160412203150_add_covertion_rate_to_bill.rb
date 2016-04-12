class AddCovertionRateToBill < ActiveRecord::Migration
  def change
    add_column :bills, :convertion_rate, :decimal
  end
end
