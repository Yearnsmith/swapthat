class User < ApplicationRecord
  rolify
  attr_writer :login #for logging in with username || email (See Devise Methods below)
  
  # T2A2-10 As a user I want to create a listing
  ## A user can have many listings. Listing refers to User as :seller
  has_many :listings, foreign_key: :seller_id

  # unique validators
  validates_uniqueness_of :email
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  # T2A2-13 As a user I want to log in
  
  ## Devise methods
  ## Login with username or email
  ## https://github.com/heartcombo/devise/wiki/How-To%3A-Allow-users-to-sign-in-using-their-username-or-email-address
  def login
    @login || self.username || self.email
  end
  
  ## continuation of above
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  # T2A2-12 As a user I want to sign up to the service
  ## Include default devise modules. Others available are:
  ## :lockable, and :timeoutable
  devise :database_authenticatable, :registerable, #:omniauthable, # => Add last
         :recoverable, :rememberable, :validatable, :trackable, :confirmable


  # As a user I want to make offers on listings
  def listings_to_offer
    available_listings(self)
  end
end
