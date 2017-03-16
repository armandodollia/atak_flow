class Answer < ActiveRecord::Base
  belongs_to :answerer, class_name: :User
  belongs_to :question
  
  validates :user_id, presence: true
  validates :question_id, presence: true
end
