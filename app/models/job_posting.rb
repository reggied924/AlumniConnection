class JobPosting < ActiveRecord::Base
  attr_accessible :address, :company, :description, :contact_email, :contact_name, :contact_phone, :position, :postedBy, :education, :salary
end
