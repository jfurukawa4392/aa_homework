class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 7, allow_nil: true}

  attr_reader :password
  after_initialize :ensure_session_token

  def self.find_by_credentials(user, pw)
    @user = User.find_by_username(user)

    @user.is_password?(pw) ? @user : nil
  end

  def is_password?(pw)
    BCrypt::Password.new(self.password_digest).is_password?(pw)
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= self.reset_session_token!
  end
end
