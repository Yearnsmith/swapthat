class User < ApplicationRecord
  # Instructions for allowing login with username:
  # => https://github.com/heartcombo/devise/wiki/How-To%3A-Allow-users-to-sign-in-using-their-username-or-email-address
  attr_writer :login

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  # Include default devise modules. Others available are:
  # :lockable, and :timeoutable
  devise :database_authenticatable, :registerable, #:omniauthable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

  # unique validators
  validates_uniqueness_of :email
  validates :username, presence: true, uniqueness: { case_sensitive: false }
end
