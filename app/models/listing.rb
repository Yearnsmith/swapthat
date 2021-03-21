class Listing < ApplicationRecord
  # T2A2-10 As a user I want to create a listing
  # => Set up relation to user, who Listing refers to as :seller
  ## => Users can both make listings (as a seller) and offer their own listings (as a buyer).
  belongs_to :seller, class_name: 'User' # May change :seller to owner?

  #Passing these through to Trade:
  delegate :username, to: :seller
  delegate :id, to: :seller, prefix: :seller
  # delegate :class, to: :seller, prefix: true
  # T2A2-18 As a user I want to make an offer on
  # other people's listings
  # THIS IS LISTING
  # TODO: change :as_listings to :as_listing_in_trades
  has_many :as_listings, foreign_key: :listing_id, class_name: 'Trade'
  has_many :offers, through: :as_listings

  # THIS IS OFFERING
  # TODO: change :as_offers to :as_offers_in_trades
  has_many :as_offers, foreign_key: :offer_id, class_name: 'Trade'
  has_many :listings, through: :as_offers

  ## T2A2-10 As a user I want to create a listing
  # => Ensure Listing object has title
  validates_presence_of :title

end
