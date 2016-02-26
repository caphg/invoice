class AddVatToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :vat, :string
  end
end
