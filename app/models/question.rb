class Question < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true
  
  belongs_to :asker, class_name: :User
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  has_many :answers
end
