class User < ActiveRecord::Base
  after_intitialize :ensure_session_token

  validates :username, :password_digest, presence: true
  attr_reader :password

  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def password=(password)
    @password = password
    @password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(@password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user && user.is_password?(password)
      return user
    end

    nil
  end
end
