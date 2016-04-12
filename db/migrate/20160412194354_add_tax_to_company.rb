class AddTaxToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :tax, :decimal
  end
end
