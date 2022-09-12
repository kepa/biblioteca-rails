class RentalsController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  def index
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def set_rental
    @book = Rental.find(params[:id])
  end

  def book_params
    params.require(:rental).permit(:book_id, :user_id)
  end

end
