# frozen_string_literal: true

class RentalsController < ApplicationController
  before_action :authorized
  before_action :set_rental, only: [:show, :edit, :update, :destroy]
  before_action :book_checked_out, only: :create
  before_action :base_index_filtering, only: :index

  def index
    #Applies filter to collection of data depending on wich user is signed in
    @rentals = apply_filter(@rentals)

    @rentals = @rentals.page(params[:page])
  end

  def show
    @book = Book.find(@rental.book_id)
  end

  def new
    @rental = Rental.new
    @book_id = params[:format]
  end

  def create
    @rental = Rental.new(rental_params)

    if @rental.save
      redirect_to rental_url(@rental)
    else
      redirect_to root_path
    end
  end

  def edit; end

  def update
    @rental.finalize

    if @rental.save
      redirect_to rental_url(@rental)
    else
      redirect_to root_path
    end
  end

  def destroy
    redirect_to root_path if @rental.destroy
  end

  private

  def set_rental
    @rental = Rental.find(params[:id])
  end

  def rental_params
    params.require(:rental).permit(:book_id, :user_id)
  end

  def book_checked_out
    redirect_to root_path if Book.checked_out?(rental_params[:book_id])
  end

  #Simple filtering given the parameters that are passed to the controller
  def apply_filter(data)
    return data.filter_by_status(params[:status]) if params[:status].present?
    return data.filter_by_checkout(params[:checkout_date_init], params[:checkout_date_end]) if params[:checkout_date_end].present?

    data
  end

  #Logic necessary to only show normal users their rentals and admins all rentals
  def base_index_filtering
    @rentals = current_user.admin? ? Rental.all : current_user.rentals
  end

  def authorized
    redirect_to root_path, flash: {notice: 'You must log-in!'} unless user_signed_in?
  end
end
