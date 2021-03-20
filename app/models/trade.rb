class Trade < ApplicationRecord
  # T2A2-18 As a user I want to make an offer on other
  # people's listings
  belongs_to :listing, class_name: 'Listing'
  belongs_to :offer, class_name: 'Listing'

  accepts_nested_attributes_for :listing, reject_if: :all_blank
  # accepts_nested_attributes_for :offer, reject_if: :all_blank
end
