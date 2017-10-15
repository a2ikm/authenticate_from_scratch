class LoginsController < ApplicationController
  def new
    @login = Login.new
  end

  def create
    @login = Login.new(login_params)
    digest = Digest::SHA1.hexdigest(@login.password)

    if (user = User.find_by(email: @login.email,
                            password_digest: digest))
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
