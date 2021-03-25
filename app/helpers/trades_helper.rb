module TradesHelper
 #move to ApplicationHelper?
  # #set attributes to minimise database calls
  # def set_current_attributes(trade) 
  #   unless trade.class == Hash
  #     @attributes = trade.attributes
  #   end
  # end

  # def seller_accepted_other_offer?(trade)
  #   set_current_attributes(trade)
  #   Trade.seller_accepted.where(listing: @attributes["listing_id"]).where.not(offer: @attributes["offer_id"]).empty?
  # end

  # def buyer_response_is_nil?(trade)
  #   set_current_attributes(trade)
  #   puts "ATTRIBUTES IN buyer_response_is_nil: #{@attributes}"
  #   if
  #     Trade.where("id = ? AND buyer_response = ?", @attributes["id"], "unactioned")
  #     return true
  #   end
  #   return false
  # end

  # def display_trade_status(trade)
  #   User.preload(:trades)
  #   set_current_attributes trade
  #   seller = trade.listing.seller
  #   buyer = trade.offer.seller
  #   seller_response = @attributes["seller_response"]
  #   puts seller_response
  #   buyer_response = @attributes["buyer_response"]

  #   # seller hasn't accepted and is current_user
  #   # buyer hasn't accepted and is current_user
  #   if ( (seller_response == "unactioned") && (current_user == seller) ) || ( (seller_response == "accept") && (buyer_response == "unactioned") && (current_user == buyer) )
  #     return :put_buttons
  #   end
  #   # seller has accepted another offers
  #   if seller_accepted_other_offer?(@attributes) && !buyer_response_is_nil?(@attributes)
  #     pp !buyer_response_is_nil(@attributes)
  #     # puts "ATTRIBUTES IN OTHER OFFER ACCEPTED CHECK: #{@attributes}"
  #     # puts "RETURNED ACCEPTED OTHER OFFER"
  #     return :accepted_other_offer
  #   end
  #   # seller has declined this offer
  #   if seller_response == "decline"
  #     puts "RETURNED SELLER_DECLINED OFFER"
  #     return :seller_decined
  #   end
  #   # Seller has accepted, but buyer hasn't, buyer isn't viewing
  #   if ( (seller_response == "accept") && (buyer_response == "unactioned") )
  #     puts "RETURNED SELLER_RESPONSE"
  #     return :seller_accepted
  #   end

  #   # seller and buyer have accepted
  #   if (seller_response == "accept") && (buyer_response == "confirm")
  #     puts "RETURNED BUYER_RESPONSE"
  #     return :buyer_confirmed
  #   end
  # end

end
