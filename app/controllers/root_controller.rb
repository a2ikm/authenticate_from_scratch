class RootController < ApplicationController
  before_action do
    unless current_user
      redirect_to new_login_url
    end
  end

  def index
  end

  private

  def current_user
    return @current_user if defined?(@current_user)

    key = request.ssl? ? cookies.signed[:secure_user_session] : cookies.signed[:user_session]
    if key
      user_id = SessionStorage.get(key)
      if user_id
        @current_user = User.find(user_id)
      else
        @current_user = nil
      end
    else
      @current_user = nil
    end

    @current_user
  end
end
