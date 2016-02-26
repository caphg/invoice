class AddSwiftToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :swift, :string
  end
end
