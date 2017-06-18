class AddLocationToUnitTable < ActiveRecord::Migration[5.1]
  def change
    add_column :units, :country, :string, null: false
    add_index :units, :country
    add_column :units, :state, :string, null: false
    add_index :units, :state
    add_column :units, :city, :string, null: false
    add_index :units, :city
  end
end
