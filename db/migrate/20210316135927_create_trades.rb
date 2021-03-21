class CreateTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :trades do |t|
      t.string :title, limit: 110, null: false
      t.references :listing, null: false, foreign_key: { to_table: :listings }, index: true
      t.references :offer, null: false, foreign_key: { to_table: :listings }, index: true
      t.string :seller_response, limit: 10, null: false, default: "unactioned"
      t.string :buyer_response, limit: 10, null: false, default: "unactioned"
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
