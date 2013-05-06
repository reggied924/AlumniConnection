class AddFacultyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :faculty, :boolean, default: false
  end
end
