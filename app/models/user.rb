class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, and :timeoutable
  devise :database_authenticatable, :registerable, #:omniauthable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

  # unique validators
  validates_uniqueness_of :email
  validates_uniqueness_of :username
end
