class ListingsController < ApplicationController
  # include UserConcerns
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_listing, only: [ :show, :edit, :update, :destroy ]
  before_action :verify_seller, only: [ :edit, :update, :destroy]

  # GET /listings or /listings.json
  def index
    @listings = Listing.all
  end

  # GET /listings/1 or /listings/1.json
  def show
    # @current_listing = Listing.find(params[:id])
    # @trade = Trade.new(listing: @current_listing)
  end
  
  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings or /listings.json
  def create
    # @listing = Listing.new(seller_id: @user.id, title: listing_params[:title], description: listing_params[:description])
    @listing = Listing.new(listing_params)
    @listing.seller = current_user
    @listing.photo.attach(listing_params[:photo])

    if @listing.save
      redirect_to @listing, notice: "Listing was successfully created."
    end
  end

  # PATCH/PUT /listings/1 or /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: "Listing was successfully updated." }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1 or /listings/1.json
  def destroy

    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: "Listing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    def verify_seller
      unless current_user && (@listing.seller == current_user)
        flash[:alert] = "You are not authorised to do this"
        # redirect_back(fallback_location: root_path)
        render :show, status: :forbidden
      end
    end

    # Only allow a list of trusted parameters through.
    def listing_params
      # user = current_user
      params.require(:listing).permit(:title, :description, :suggestion, :photo)
    end
end
