class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user

  validates_uniqueness_of :like, scope: [:user_id, :voteable_id, :voteable_type]

end
