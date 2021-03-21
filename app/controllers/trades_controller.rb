class TradesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_trade, only: %i[ show edit destroy ]
  # before_action :set_listing, only: %i[create edit update]

  # GET /trades or /trades.json
  def index
    # @trades = Trade.eager_load(:trades)
  end
  # GET /trades/1 or /trades/1.json
  def show
  end
  # GET /trades/new
  # def new
  #   @trade = 
  #   Trade.new(listing_id: params[:listing])
  # end

  # GET /trades/1/edit
  def edit
  end

  def create
    # T2A2-18 make an offer on other peoples' listings
    # Get @listing from listings/trades_controller,

    # Create a new trade using @listing's id
    # Store the new trade in instance variable
    if trade_params["offer_id"] != ""
      @trade = @current_listing.as_listings.new(trade_params) #wrong?
    else
      @offer = trade_params[:listing_attributes]
      @trade = @current_listing.as_listings.new(
          offer: Listing.create(
              seller: current_user, 
              title: @offer[:title], 
              description: @offer[:description], 
              suggestion: @offer[:suggestion],
              ))
    end
    # Check to see if listing is a pending offer before processing any more code.
    # TODO: Refactor logic to Model
    if @current_listing.locked == true
      render "listings/show", flash.now[:alert] = "This item is currently being offered to a trade" and return
    end
    # Set title for trade using titles of both listings.
    @trade.title = "#{@trade.offer_title } for #{ @current_listing.title }"

      # Try to save listing
      if @trade.save!
        # If successful, mark the offer as locked
        @trade.offer.update!(locked: true)
        # Redirect to @listing page
        # render "listings/show", notice: "Offer was created successfully!"
        redirect_to @current_listing, notice: "Offer was created successfully. Good luck! :)"
      else
        redirect_back fallback_location: listings_path, flash: { status: :unprocessable_entity}
      end
  end
  # PATCH/PUT /trades/1 or /trades/1.json
  def update
    trade = Trade.find(params["trade"].to_i)
    if params["respond"] == "accept"
      if current_user.id == trade.listing.seller_id
        trade.listing.update(locked: true)
        disable_other_offers(trade)
        trade.update(seller_response: "accept")
        redirect_to trade.listing, notice: "Offer accepted!" and return
      elsif current_user.id == trade.offer.seller.id
        trade.update(buyer_response: "confirm")
        trade.offer.update(locked: true)
        redirect_to trade.listing, notice: "Trade confirmed. Hooray!" and return
      end
    end
    redirect_to trade.listing, alert: "Oops, something went wrong!" and return
    # if !params.include? "trade"
    #   @trade.
    # respond_to do |format|
    #   if @trade.update(trade_params)
    #     format.html { redirect_to @trade, notice: "Trade was successfully updated." }
    #     format.json { render :show, status: :ok, location: @trade }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @trade.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /trades/1 or /trades/1.json
  def destroy
    @trade.destroy
    respond_to do |format|
      format.html { redirect_to trades_url, notice: "Trade was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def disable_other_offers(trade)
    Trade.includes(:offer).where("trades.offer_id != ?", trade.offer.id).map {|t| t.update!(active: false)}
  end
    # def self.to_struct
    #   Struct.new(*(k = self.attributes.keys)).new(*self.attributes.values_at(*k))
    # end

    # Use callbacks to share common setup or constraints between actions.
    def set_trade
     @trade = Trade.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def trade_params
      params.require(:trade).permit(:listing_id, :offer_id, :id, :listing, listing_attributes: [:title, :description, :suggestion])
    end

    # def set_listing
    #   @current_listing = Listing.find(params[:listing_id])
    # end

    def verify_owner
      unless current_user && (@offer.seller == current_user)
        flash[:alert] = "You are not authorised to do this"
        redirect_back(fallback_location: :index)
      end
    end

    def link_to_back
      redirect_back(fallback_location: :trade)
    end

end
