class Vote < ActiveRecord::Base
  belongs_to :voter, class_name: :User
  belongs_to :votable, polymorphic: true
  
  validates :value, presence: true
  validates :user_id, presence: true
  validates :votable_id, presence: true
  validates :votable_type, presence: true
end
