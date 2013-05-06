class AddLongitudeToWorkplaces < ActiveRecord::Migration
  def change
    add_column :workplaces, :longitude, :float
  end
end