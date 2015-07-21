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

  def check_like(model)
    model.votes.where(user: self).first
  end

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid).first
    return authorization.user if authorization

    email = auth.info.try(:email)
    if email
      user = User.where(email: email).first
    else
      return nil
    end

    if user
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
    else
      user = generate_user(email)
      user.skip_confirmation!
      user.save
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
    end
    user
  end

  def self.generate_user(email)
    password = Devise.friendly_token[0, 20]
    user = User.new(email: email, password: password, password_confirmation: password)
    user
  end
end
