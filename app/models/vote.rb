 class Vote < ActiveRecord::Base
  belongs_to :voter, class_name: :User, foreign_key: :user_id
  belongs_to :votable, polymorphic: true

  validates :value, presence: true
  validates :user_id, presence: true
  validates :votable_id, presence: true
  validates :votable_type, presence: true

  def question
    return self.commentable if self.commentable_type == "Question"
    nil
  end

  def answer
    return self.commentable if self.commentable_type == "Answer"
    nil
  end

  def comment
    return self.commentable if self.commentable_type == "Comment"
    nil
  end
  
  def points
    
  end
end
