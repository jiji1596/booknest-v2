# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'json'
require 'open-uri'
require 'nokogiri'

puts "Cleaning the DB...."
Booking.destroy_all
BookOffer.destroy_all
Book.destroy_all
User.destroy_all



puts "Fetching books from Open Library..."
url = URI("https://openlibrary.org/search.json?publisher=penguin")
response = URI.open(url).read
data = JSON.parse(response)
created_count = 0

data["docs"].each do |item|
  Book.create!(
    title: item["title"],
    author: item["author_name"]&.first,
    published_year: item["first_publish_year"],
    image_url: "https://covers.openlibrary.org/b/id/#{item["cover_i"]}-L.jpg"
  )
end

# books = Book.limit(10)

puts "Creating default users..."


READERS = %w[Ryan Hayao Julian Kaho Nathaniel Naw Owen Hikari Tsering William]
GENDER = %w[male female]

READERS.each_with_index do |reader, index|
  user = User.new(
    email: "test#{index}@gmail.com",
    password: '123123',
    user_name: reader,
    address: "日本, 〒153-0063 東京都目黒区 目黒#{rand(1..3)}丁目#{rand(1..7)}番#{rand(1..3)}号",
    latitude: rand(35.64132351477831...35.622592654954566),
    longitude:rand(139.68341078703912...139.7128936270011)
  )

  url = "https://this-person-does-not-exist.com/new?gender=#{GENDER.sample}&age=#{'50+'}"
  json = URI.open(url).string
  src = JSON.parse(json)['src']
  photo_url = "https://this-person-does-not-exist.com#{src}"
  file = URI.open(photo_url)
  user.profile_photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
  user.save

  book = Book.find_by(title: "Dune")

  book_offer = BookOffer.new(
  availability: true, # alternate true/false
  description: "Book offer by #{user.user_name}",
  user: user,
  book: book
  )
  photo_url_2 = ["dune2.jpg", "dune3.jpeg", "dune4.jpg", "dune5.jpg"]
  file_2 = File.open("./app/assets/images/#{photo_url_2.sample}")
  book_offer.photo.attach(io: file_2, filename: 'user.png', content_type: 'image/png')


  book_offer.save
end



# puts "Fetching books from Open Library..."
# url = URI("https://openlibrary.org/search.json?publisher=penguin")
# response = URI.open(url).read
# data = JSON.parse(response)
# created_count = 0

# data["docs"].each do |item|
#   Book.create!(
#     title: item["title"],
#     author: item["author_name"]&.first,
#     published_year: item["first_publish_year"],
#     image_url: "https://covers.openlibrary.org/b/id/#{item["cover_i"]}-L.jpg"
#   )
# end

# books = Book.limit(10)

# # Create 10 book offers by User.first
# book_offers = books.map.with_index do |book, i|
#   BookOffer.create!(
#     availability: i.even?, # alternate true/false
#     description: "Book offer ##{i + 1} by #{user1.user_name}",
#     user: user1,
#     book: book
#   )
# end

# # Create 5 bookings with User.last, each for a different book offer
# book_offers.first(5).each_with_index do |offer, i|
#   Booking.create!(
#     starting_date: Date.today + i,
#     ending_date: Date.today + i + 7,
#     status: :pending,
#     user: user2,
#     book_offer: offer
#   )
# end

# puts "Fetched #{data['docs'].length} books from API"

# # put user seeds, faker, down here!
