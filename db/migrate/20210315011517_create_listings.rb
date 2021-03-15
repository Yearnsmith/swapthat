class CreateListings < ActiveRecord::Migration[6.0]
  def change
    create_table :listings do |t|
      t.string :title, limit: 50, null: false
      t.text :description, limit: 600
      t.references :seller, null: false, foreign_key: { to_table: :users }, index: true
      t.boolean :locked, default: 0

      t.timestamps
    end
  end
end
