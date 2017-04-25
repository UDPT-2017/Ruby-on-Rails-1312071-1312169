class User < ApplicationRecord
  has_secure_password

  before_save :downcase_email

  has_many :entries, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.max_name_leng}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: Settings.max_email_leng},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: Settings.min_password_leng},
    if: -> {self.new_record?}

  def forget
    update_attribute :remember_digest, nil
  end

  def self.login_from_omniauth(auth)
    find_by(uid: auth["uid"]) ||
            create_member_from_omniauth(auth)
  end

  def self.create_member_from_omniauth(auth)
    new(
      provider: auth["provider"],
      uid: auth["uid"],
      name: auth["info"]["name"],
      email: auth["info"]["email"])
  end

  private
  def downcase_email
    email.downcase! if email
  end
end
