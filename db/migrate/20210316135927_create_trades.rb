class CreateTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :trades do |t|
      t.string :title, limit: 110, null: false
      t.references :listing, null: false, foreign_key: { to_table: :listings }, index: true
      t.references :offer, null: false, foreign_key: { to_table: :listings }, index: true
      t.boolean :seller_accepted
      t.boolean :buyer_accepted
      t.boolean :active, null: false, default: true

      t.timestamps
    end
  end
end
