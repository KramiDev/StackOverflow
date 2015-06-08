class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user

  validates :title, :body, presence: true
  validates :title, length: { minimum: 3, maximum: 150 }
end
