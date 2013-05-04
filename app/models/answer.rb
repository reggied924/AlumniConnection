class Answer < ActiveRecord::Base
  belongs_to :question
  attr_accessible :question_id, :content
end
