class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  # => Ensure that locked listings aren't available
  # to show or select.
  def available_listings(object)
    object.listings.where(locked: false)
  end
end
