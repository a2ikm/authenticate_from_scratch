module SessionStorage
  class <<self
    def set(key, value, expires_in)
      Rails.cache.write(key, value, expires_in: expires_in)
    end

    def get(key)
      Rails.cache.read(key)
    end
  end
end
