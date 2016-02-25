class RemoveCurrencyFromService < ActiveRecord::Migration
  def change
    remove_column :services, :currency, :string
  end
end
