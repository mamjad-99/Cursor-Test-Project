class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :customer_name
      t.decimal :freight
      t.string :ship_name
      t.string :ship_country

      t.timestamps
    end
  end
end
