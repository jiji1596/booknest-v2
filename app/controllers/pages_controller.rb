class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home
  def home
    if params[:query].present?
      @books = Book.search_by_title_and_author(params[:query])
    else
      @books = Book.all
    end
  end
end
