class Vote < ActiveRecord::Base
  validates :value, presence: true
  validates :user_id, presence: true
  validates :votable_id, presence: true
  validates :votable_type, presence: true
  
  belongs_to :voter, class: :User
end
