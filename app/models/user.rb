class User < ApplicationRecord
  before_create do
    self.password_salt = SecureRandom.hex(32)
  end
end
