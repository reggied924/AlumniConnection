class Workplace < ActiveRecord::Base
  attr_accessible :address, :company, :phone, :position, :user_email, :user_id
  belongs_to :user, foreign_key: "user_id"
  acts_as_gmappable
  
  validates :user_email, presence: true
  validates :position,   presence: true 
  validates :company,    presence: true 
  validates :address,    presence: true 
  
  
  def gmaps4rails_address
    "#{company}, #{address}"
  end
end
