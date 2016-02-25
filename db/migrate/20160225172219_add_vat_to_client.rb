class AddVatToClient < ActiveRecord::Migration
  def change
    add_column :clients, :vat, :string
  end
end
