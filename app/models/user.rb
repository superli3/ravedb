class User < ApplicationRecord
	before_save { self.email = email.downcase }
  VALID_USERNAME_REGEX = /\A[a-z0-9\-_]+\z/i
	validates :username,  presence: true, length: { maximum: 50 },
                    format: { with: VALID_USERNAME_REGEX },
                    uniqueness: { case_sensitive: false }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 200 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password, presence: true, length: { minimum: 6 }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
