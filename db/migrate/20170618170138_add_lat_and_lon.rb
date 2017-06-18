class AddLatAndLon < ActiveRecord::Migration[5.1]
  def change
  add_column :units, :lat, :decimal, {:precision=>10, :scale=>6}
  add_column :units, :lng, :decimal, {:precision=>10, :scale=>6}
  end
end
