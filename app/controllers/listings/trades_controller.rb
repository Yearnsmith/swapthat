# Defines a controller for the nested route. This ensures that the parent 'trades_controller'
# has a @listing to deal with.
class Listings::TradesController < TradesController
  
  before_action :set_listing, only: %i[create edit update]


  private

    def set_listing
      @current_listing = Listing.find(params[:listing_id])
      puts "#{@current_listing.title} has been passed through. Hurray!"
      puts "trade_params: #{trade_params[:listing_attributes]}"
    end

end