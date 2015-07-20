class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :callback_hash

  def facebook
    @user = User.find_for_oauth(@hash)
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'facebook') if is_navigational_format?
    end
  end

  def twitter
    @user = User.find_for_oauth(@hash)
    if @user && @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'twitter') if is_navigational_format?
    else
      @user = User.new
      @user.authorizations.build(provider: @hash.provider, uid: @hash.uid)
      render 'omniauth_callbacks/email_confirmation', locals: { user: @user }
    end
  end

  def email_confirmation
    password = Devise.friendly_token[0, 20]
    @user = User.new(user_params.merge(password: password, password_confirmation: password))
    @user.save
    if @user
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'twitter') if is_navigational_format?
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, authorizations_attributes: [:provider, :uid])
  end

  def callback_hash
    @hash = request.env['omniauth.auth']
  end
end