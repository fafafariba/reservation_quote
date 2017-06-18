class AddTaxPercent < ActiveRecord::Migration[5.1]
  def change
    add_column :day_prices, :tax_percent, :decimal, :precision => 8, :scale => 2
  end
end
