class AddEducationFieldToJobPostings < ActiveRecord::Migration
  def change
    add_column :job_postings, :education, :text
  end
end