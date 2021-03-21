module TradesHelper
 
  #set attributes to minimise database calls
  def set_current_attributes(trade) 
    unless trade.class == Hash
      @attributes = trade.attributes
    end
  end

  def seller_accepted_other_offer?(trade)
    set_current_attributes(trade)
    if Trade.seller_accepted.where(listing: 16).where.not(offer: 17).empty?
      return false
    else
      return true
    end
  end

  def buyer_response_is_nil?(trade)
    set_current_attributes(trade)
    if
      Trade.where("id = ? AND buyer_response = ?", @attributes["id"], "unactioned")
      return true
    end
    return false
  end

  def display_trade_status(trade)
    set_current_attributes trade
    seller = trade.listing.seller
    buyer = trade.offer.seller
    seller_response = @attributes["seller_response"]
    buyer_response = @attributes["buyer_response"]

    # seller hasn't accepted and is current_user
    # buyer hasn't accepted and is current_user
    if ( (seller_response == "unactioned") && (current_user == seller) ) || ( (seller_response == "accept") && (buyer_response == "unactioned") && (current_user == buyer) )
      puts "RETURNED PUT BUTTONS"
      return :put_buttons
    end
    # seller has accepted another offers
    if seller_accepted_other_offer?(@attributes) && buyer_response_is_nil?(@attributes)
      puts "RETURNED SELLER_DECLINED"
      return :seller_declined
    end
    # Seller has accepted, but buyer hasn't, buyer isn't viewing
    if ( (seller_response == "accept") && (buyer_response == "unactioned") )
      puts "RETURNED SELLER_RESPONSE"
      return :seller_accepted
    end

    # seller and buyer have accepted
    if (seller_response == "accept") && (buyer_response == "confirm")
      puts "RETURNED BUYER_RESPONSE"
      return :buyer_confirmed
    end
  end
=begin
    <% when false %>
        <h3 style="text-align: center">Offer Declined</h3>
        This offer has been declined.
    <% end %>
<% else %>
    <h3 style="text-align: center">Offer Declined</h3>
    This offer has been declined.
<% end %>
=end
end
