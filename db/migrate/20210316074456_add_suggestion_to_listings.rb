class AddSuggestionToListings < ActiveRecord::Migration[6.0]
  def change
    add_column :listings, :suggestion, :text, limit: 400
  end
end
