class User < ApplicationRecord
  has_secure_password
  before_save { email.downcase! }
  validates :password, presence: true, length: { minimum: 8 }
  validate :password_complexity
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 100 }, format: { with: VALID_EMAIL_REGEX, message: "Invalid email format" }

  def password_complexity
    return if password.blank?

    unless password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/)
      errors.add(:password, "must include at least one uppercase letter, one lowercase letter, one number, and one special character")
    end
  end
end
