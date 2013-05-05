class CreateJobPostings < ActiveRecord::Migration
  def change
    create_table :job_postings do |t|

      t.timestamps
    end
  end
end
