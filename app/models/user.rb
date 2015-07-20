class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :confirmable

  has_many :questions, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :authorizations
  accepts_nested_attributes_for :authorizations

  def self.check_like(model, user)
    model.votes.where(user: user).first
  end

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid).first
    return authorization.user if authorization

    email = auth.info.email
    if email
      user = User.where(email: email).first
    else
      return false
    end

    if user
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
    else
      password = Devise.friendly_token[0, 20]
      user = User.create(email: email, password: password, password_confirmation: password)
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
    end
    user
  end
end
