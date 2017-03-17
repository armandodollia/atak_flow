class Answer < ActiveRecord::Base
  belongs_to :answerer, class_name: :User, foreign_key: :user_id
  belongs_to :question
  has_many :comments, as: :commentable
  has_many :votes, as: :votable

  validates :user_id, presence: true
  validates :question_id, presence: true
  validates :body, presence: true
end
