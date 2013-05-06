class AddLatitudeToWorkplaces < ActiveRecord::Migration
  def change
    add_column :workplaces, :latitude, :float
  end
end
