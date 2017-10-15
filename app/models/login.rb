class Login
  include ActiveModel::Model
  attr_accessor :email, :password, :original_name

  def authenticate
    user = User.find_by(email: email)
    return if user.nil?

    digest = Digest::SHA1.hexdigest(@login.password)
    digest == user.password_digest ? user : nil
  end
end
