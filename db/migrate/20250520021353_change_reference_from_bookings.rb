class ChangeReferenceFromBookings < ActiveRecord::Migration[7.1]
  def change
    remove_reference :bookings, :book, foreign_key: true
    add_reference :bookings, :book_offer, null: false, foreign_key: true
  end
end
