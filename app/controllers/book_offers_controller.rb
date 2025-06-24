class BookOffersController < ApplicationController
  skip_before_action :authenticate_user!, only: :show
  def show
    @book_offer = BookOffer.find(params[:id])
  end

  def new
  @book_offer = BookOffer.new
  end

  def create
    @book_offer = BookOffer.new(book_offer_params)
    @book = Book.find(book_offer_params[:book_id])
    @book_offer.user = current_user
    @book_offer.book = @book
    if @book_offer.save
      # TODO: change path once the new books index is made
      redirect_to owner_bookings_path
    else
      render :new
    end
  end


  def book_offer_params
    params.require(:book_offer).permit(:description, :photo, :book_id)
  end
end
