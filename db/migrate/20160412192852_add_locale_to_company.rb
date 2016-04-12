class AddLocaleToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :locale, :string
  end
end
