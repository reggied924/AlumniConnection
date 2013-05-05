class Resume < ActiveRecord::Base
  attr_accessible :name, :data, :filename, :mime_type
  belongs_to :user
  
end
