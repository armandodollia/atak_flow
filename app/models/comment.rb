class Comment < ActiveRecord::Base
  belongs_to :commenter, class_name: User
  belongs_to :commentable, polymorphic: true
  has_many :votes, as: :votable
  
  validates :body, presence: true
  validates :user_id, presence: true
  validates :commentable_id, presence: true
  validates :commentable_type, presence: true
  
  def question
    return self.commentable if self.commentable_type == "Question"
    nil
  end

  def answer
    return self.commentable if self.commentable_type == "Answer"
    nil
  end
end