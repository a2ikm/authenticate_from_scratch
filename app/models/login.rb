class Login
  include ActiveModel::Model
  attr_accessor :email, :password, :original_name

  def authenticate
    digest = Digest::SHA1.hexdigest(@login.password)
    User.find_by(email: email, password_digest: digest)
  end
end
