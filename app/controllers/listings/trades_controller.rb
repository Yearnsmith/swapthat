# Defines a controller for the nested route. This ensures that the parent 'trades_controller'
# has a @listing to deal with.
class Listings::TradesController < TradesController
  
  before_action :set_listing, only: %i[create edit update]
  # authorize_resource :listing


  private

    def set_listing
      @current_listing = Listing.find(params[:listing_id])
      # @trade_params = trade_params[:listing_attributes]
      puts "#{@current_listing.title} has been passed through. Hurray!"
      puts "trade_params: #{trade_params[:listing_attributes]}"
    end

    # def trade_params
    #   params.require(:trade).permit( :offer_id, :id, listing_attributes: [ :title, :description, :suggestion ] ) 
    # end
    # def id_params
    #   params.permit(:id)
    # end

end