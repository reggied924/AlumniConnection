class AddGmapsToWorkplaces < ActiveRecord::Migration
  def change
    add_column :workplaces, :gmaps, :boolean
  end
end
