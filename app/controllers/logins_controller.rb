class LoginsController < ApplicationController
  def new
    @login = Login.new
  end

  def create
    @login = Login.new(login_params)

    if user = @login.authenticate
      reset_session
      session[:user] = user.id

      redirect_to sanitize_url(@login.original_url) || root_url
    else
      @login.errors[:base] << "Please enter a correct username and password."

      render :new
    end
  end

  private

  def login_params
    params.require(:login).permit(:email, :password, :original_url)
  end

  def set_login_cookies(user_id)
    key        = SecureRandom.uuid
    secure_key = SecureRandom.uuid

    expires_in = 1.week
    expires_at = expires_in.from_now

    SessionStorage.set(key,        user_id, expires_in)
    SessionStorage.set(secure_key, user_id, expires_in)

    cookies.signed[:user_session] = {
      expires:  expires_at,
      value:    key,
      httponly: true,
    }
    cookies.signed[:secure_user_session] = {
      expires:  expires_at,
      value:    secure_key,
      httponly: true,
      secure:   true,
    }
  end

  def sanitize_url(url)
    URI.parse(url).host == request.host ? url : nil
  rescue
    nil
  end
end
