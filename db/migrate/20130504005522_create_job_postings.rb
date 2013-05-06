class CreateJobPostings < ActiveRecord::Migration
  def change
    create_table :job_postings do |t|
      t.string :company
      t.string :address
      t.string :position
      t.string :contact_name
      t.string :contact_phone
      t.string :contact_email
      t.string :postedBy

      t.timestamps
    end
  end
end