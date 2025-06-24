class CreateBookOffers < ActiveRecord::Migration[7.1]
  def change
    create_table :book_offers do |t|
      t.boolean :availability
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
