class AddSalaryToJobPostings < ActiveRecord::Migration
  def change
    add_column :job_postings, :salary, :string
  end
end
