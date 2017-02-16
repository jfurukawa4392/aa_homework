class User < ActiveRecord::Base
  validates :email, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true

  after_initialization :ensure_session_token

  def self.find_by_credentials(email, pw)
    user = User.find_by_email(email)

    if user
      user.is_password?(pw) ? user : nil
    else
      nil
    end
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save
    self.session_token
  end

  def password=(pw)
    @password = pw
    self.password_digest = BCrypt::Password.create(pw)
  end

  def is_password?(pw)
    user_hash = BCrypt::Password.new(self.password_digest)
    user_hash.is_password?(pw)
  end

  private
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end
end
