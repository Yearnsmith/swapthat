class TradesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_trade, only: %i[ show edit update destroy ]
  # before_action :set_listing, only: %i[ new create update ]

  # GET /trades or /trades.json
  def index
    @trades = Trade.all
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
      @trade = @as_listing.as_listings.new(trade_params)
    else
      @as_offer = trade_params[:listing_attributes]
      @trade = @as_listing.as_listings.new(title: @as_offer[:title], description: @as_offer[:description], suggestion: @as_offer[:suggestion])
    end
    # Check to see if listing is a pending offer before processing any more code.
    # TODO: Refactor logic to Model
    if Listing.find(@as_listing.id).locked == true
      render "listings/show", flash.now[:alert] = "This item is currently being offered to a trade" and return
    end
    # Set title for trade using titles of both listings.
    @trade.title = "#{@trade.offer.title } for #{ @trade.listing.title }"

      # Try to save listing
      if @trade.save
        # If successful, mark the offer as locked
        @trade.offer.update(locked: true)
        # Redirect to @listing page
        # render "listings/show", notice: "Offer was created successfully!"
        redirect_to @as_listing, notice: "Offer was created successfully!"
      else
        redirect_back fallback_location: listings_path, flash: { status: :unprocessable_entity}
      end
  end

  # PATCH/PUT /trades/1 or /trades/1.json
  def update
    respond_to do |format|
      if @trade.update(trade_params)
        format.html { redirect_to @trade, notice: "Trade was successfully updated." }
        format.json { render :show, status: :ok, location: @trade }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trade.errors, status: :unprocessable_entity }
      end
    end
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
    # Use callbacks to share common setup or constraints between actions.
    def set_trade
      @trade = Trade.find(params[:id])
    end

    # def set_listing
    #   @listing = Listing.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def trade_params
      params.require(:trade).permit(:listing_id, :offer_id, :id, listing_attributes: [:title, :description, :suggestion])
    end

    def verify_owner
      unless current_user && (@offer.seller == current_user)
        flash[:alert] = "You are not authorised to do this"
        # redirect_back(fallback_location: root_path)
        redirect_back(fallback_location: :index)
      end
    end

end
