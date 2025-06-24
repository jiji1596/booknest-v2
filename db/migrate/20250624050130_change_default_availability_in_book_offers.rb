class ChangeDefaultAvailabilityInBookOffers < ActiveRecord::Migration[7.1]
  def change
    change_column_default :book_offers, :availability, from: nil, to: true
  end
end
