class AddUserEmailToWorkplaces < ActiveRecord::Migration
  def change
    add_column :workplaces, :user_email, :string
  end
end
