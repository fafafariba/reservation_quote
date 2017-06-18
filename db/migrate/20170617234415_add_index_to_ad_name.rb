class AddIndexToAdName < ActiveRecord::Migration[5.1]
  def change
    add_index :units, :ad_name, unique: true
  end
end
