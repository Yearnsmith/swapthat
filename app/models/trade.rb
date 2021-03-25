class Trade < ApplicationRecord
  resourcify
  # T2A2-18 As a user I want to make an offer on other
  # people's listings
  belongs_to :listing, class_name: 'Listing'#, inverse_of: :as_listings
  belongs_to :offer, class_name: 'Listing'#, inverse_of: :as_offers

  has_many_attached :photo

  delegate :title, :id, to: :listing, prefix: true
  # => trade.listing.title, as listing_title
  delegate :title, :id, to: :offer, prefix: true
  # => trade.offer.title, as offer_title
  delegate :username, :id, to: :listing, prefix: :seller
  # => trade.listing.user.username as trade.seller_username
  delegate :username, :id, to: :offer, prefix: :buyer
  # => trade.offer.user.username as trade.buyer_username
  
  accepts_nested_attributes_for :offer, reject_if: :all_blank

  #####################
# SCOPES
## All active Trades
scope :active,      -> {where(active: true)}
## All current_users' trades
scope :user_trades, -> {includes(:listing).where('listings.seller_id = ?', current_user)}
## Trade Ownershio
# scope :trade_seller, -> {where(listing: self.listing).seller.username}
trade_seller = Trade.includes(:listing).includes(:seller)
## Trade Acceptance 
scope :seller_accepted,   -> {where(seller_response: "accept")}
scope :seller_unactioned, -> {where(seller_response: "unactioned")}
# scope :seller_declined, -> {where(seller_response: "decline")}
scope :buyer_confirmed,   -> {where( buyer_response: "confirmed")}
scope :buyer_unactioned,  -> {where( buyer_response: "unactioned")}
# scope :buyer_declined,  -> {where( buyer_response: "decline")}
scope :trade_declined,    -> {where(seller_response: "decline").or(buyer_response: decline)}
scope :trade_accepted,    -> {:seller_accepted && :buyer_confrimed}
  
  # before_action :set_trade, only: %i[ show edit destroy ]

  # def self.to_struct
  #   s = self.attributes
  #   Struct.new('TradeObject',*(k = s.keys)).new(*s.values_at(*k))
  # end
  private


end
