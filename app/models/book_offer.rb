class BookOffer < ApplicationRecord
  belongs_to :user
  has_many :bookings
  belongs_to :book
  has_one_attached :photo
end
