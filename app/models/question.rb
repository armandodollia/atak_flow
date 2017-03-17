class Question < ActiveRecord::Base
  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true

  belongs_to :asker, class_name: :User, foreign_key: :user_id
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
  has_many :answers

  #returns a boolean if select finds an answer marked as correct
  def solved?
    !!self.answers.select {|x| x.correct}[0]
  end

  #if solved, return the solution, else solution = nil
  def solution
    return self.answers.select {|x| x.correct}[0] if solved?
    nil
  end
end
