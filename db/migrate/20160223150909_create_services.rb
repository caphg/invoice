class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.string :description
      t.integer :amount
      t.string :currency
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
