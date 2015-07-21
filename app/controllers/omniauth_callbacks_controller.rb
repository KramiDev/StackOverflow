class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :callback_hash

  def facebook
    @user = User.find_for_oauth(@hash)
    if @user and @user.persisted?
      sign_in_auth(@user, 'facebook')
    end
  end

  def twitter
    @user = User.find_for_oauth(@hash)
    if @user and @user.persisted?
      sign_in_auth(@user, 'twitter')
    else
      @user = User.new
      session[:auth_provider] = @hash.provider
      session[:auth_uid] = @hash.uid
      render 'omniauth_callbacks/email_confirmation'
    end
  end

  def email_confirmation
    @user = User.create_new_user(user_params)
    @user.authorizations.build(provider: session[:auth_provider], uid: session[:auth_uid])
    @user.save
    if @user
      sign_in_auth(@user, 'twitter')
    end
  end

  private

  def sign_in_auth(user, kind)
    sign_in_and_redirect user, event: :authentication
    set_flash_message(:notice, :success, kind: kind) if is_navigational_format?
  end

  def user_params
    params.require(:user).permit(:email)
  end

  def callback_hash
    @hash = request.env['omniauth.auth']
  end
end