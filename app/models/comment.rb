class Comment < ActiveRecord::Base
  belongs_to :commenter, class_name: User
  
  validates :body, presence: true
  validates :user_id, presence: true
  validates :commentable_id, presence: true
  validates :commentable_type, presence: true
end
