class AddCurrencyToBill < ActiveRecord::Migration
  def change
    add_column :bills, :currency, :string
  end
end
