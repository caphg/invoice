class AddCityToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :city, :string
  end
end
