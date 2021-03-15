class Listing < ApplicationRecord
  # T2A2-10 As a user I want to create a listing
  ## Set up relation to user, who Listing refers to as :seller
  ## => Users can both make listings (as a seller) and offer their own listings (as a buyer).
  belongs_to :seller, class_name: 'user'

  ## Ensure Listing object has title
  validates_presence_of :title
end
