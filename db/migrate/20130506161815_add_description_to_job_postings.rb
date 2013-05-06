class AddDescriptionToJobPostings < ActiveRecord::Migration
  def change
    add_column :job_postings, :description, :text
  end
end
