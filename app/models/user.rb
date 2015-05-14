class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6 }

  attr_reader :password


  def password=(password)

  end

end
