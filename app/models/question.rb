class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy

  validates :title, :body, presence: true
  validates :title, length: { minimum: 3, maximum: 150 }
end
