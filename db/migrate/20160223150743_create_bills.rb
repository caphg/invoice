class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :notice
      t.string :footer

      t.timestamps null: false
    end
  end
end
