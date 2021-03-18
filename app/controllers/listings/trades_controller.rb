# Defines a controller for the nested route. This ensures that the parent 'trades_controller'
# has a @listing to deal with.
class Listings::TradesController < TradesController
  before_action :set_listing

  private

    def set_listing
      @as_listing = Listing.find(params[:listing_id])
      # @as_offer = trade_params[:listing_attributes]
      puts "============"
      puts "== PASSED =="
      puts "============"
    end

    def trade_params
      params.require(:trade).permit(
                                    :listing_id, 
                                    :offer_id, 
                                    :id, 
                                    listing_attributes: [
                                                          :title, 
                                                          :description, 
                                                          :suggestion
                                                        ]
                                    ) 

    end
end