class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :book_offer
  has_many :messages

  enum status: [ :pending, :accepted, :rejected ]
  validates :starting_date, presence: true
  validates :ending_date, presence: true
  validates :starting_date, date: {
    after_or_equal_to: Date.today
  }
  validates :ending_date, date: {
    after: :starting_date
  }
end
