class LoginsController < ApplicationController
  def new
    @login = Login.new
  end

  def create
    @login = Login.new(login_params)

    if user = @login.authenticate
      reset_session
      session[:user] = user.id

      redirect_to @login.original_url || root_url
    else
      @login.errors[:base] << "Please enter a correct username and password."

      render :new
    end
  end

  private

  def login_params
    params.require(:login).permit(:email, :password, :original_url)
  end
end
