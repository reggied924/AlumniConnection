class AddUserIdToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :user_id, :int
  end
end
