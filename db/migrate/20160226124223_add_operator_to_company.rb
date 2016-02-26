class AddOperatorToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :operator, :string
  end
end
