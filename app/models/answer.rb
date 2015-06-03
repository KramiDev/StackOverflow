class Answer < ActiveRecord::Base

  belongs_to :question

  validates :body, presence: true
  validates :body, length: { minimum: 3, maximum: 1000 }

end
