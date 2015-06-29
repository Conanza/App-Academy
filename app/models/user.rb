class User < ActiveRecord::Base
  validates :username, uniqueness: true, presence: true
  validates :password_digest, presence: true

  after_initialize :set_session_token

  has_many :cats
  has_many :cat_rental_requests

  def self.find_by_credentials(credentials = {})
    user = User.find_by(username: credentials["username"])

    if user && user.is_password?(credentials["password"])
      return user
    end

    nil
  end

  def set_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end
