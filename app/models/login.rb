class Login
  include ActiveModel::Model
  attr_accessor :email, :password, :original_name

  NITERATIONS = 20000
  DIGEST_ALGORITHM =  OpenSSL::Digest::SHA512.new
  KEY_LEN = DIGEST_ALGORITHM.length

  def authenticate
    user = User.find_by(email: email)
    return if user.nil?

    digest_bytes = OpenSSL::PKCS5.pbkdf2_hmac(password,
                                              user.password_salt,
                                              NITERATIONS,
                                              KEY_LEN,
                                              DIGEST_ALGORITHM)
    password_digest = digest_bytes.unpack("H*").first

    Rack::Utils.secure_compare(password_digest, user.password_digest) ? user : nil
  end
end
