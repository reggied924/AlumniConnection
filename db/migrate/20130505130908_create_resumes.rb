class CreateResumes < ActiveRecord::Migration
  def self.up
    create_table :resumes  do |t|
      t.string :name,         :null => false
      t.binary :data,         :null => false
      t.string :filename
      t.string :mime_type
      t.timestamps
    end
  end
 
  def self.down
    drop_table :resumes 
  end
end