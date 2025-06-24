class Owner::BookingsController < ApplicationController
  def index
    @pending_as_owner = current_user.bookings_as_owner.where(status: "pending")
    @accepted_as_owner = current_user.bookings_as_owner.where(status: "accepted").where("ending_date >= ?", Date.today)
    @past_as_owner = current_user.bookings_as_owner.where("ending_date < ?", Date.today)
    @my_books = current_user.book_offers.includes(:book)
    @bookings_as_owner = current_user.bookings_as_owner
  end

  def show
    @booking = Booking.find(params[:id])
    @message = Message.new
  end

  def update
    @booking = Booking.find(params[:id])
    if params[:status].present? && %w[accepted rejected].include?(params[:status])
      @booking.update(status: params[:status])
      flash[:notice] = "Booking has been #{params[:status]}."
    else
      flash[:alert] = "Invalid action."
    end

    redirect_to owner_bookings_path(status: "pending")
  end
end
