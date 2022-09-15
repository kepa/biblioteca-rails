# frozen_string_literal: true

class RentalsController < ApplicationController
  before_action :set_rental, only: [:show, :edit, :update, :destroy]
  before_action :book_checked_out, only: :create
  before_action :base_index_filtering, only: :index

  def index
    if params[:status].present?
      current_user.admin? ? @rentals = Rental.all.filter_by_status(params[:status]).page(params[:pages]) : @rentals = current_user.rentals.filter_by_status(params[:status]).page(params[:page])
    end

    if params[:checkout_date_init].present?
      @rentals = if current_user.admin?
                   Rental.all.filter_by_checkout(params[:checkout_date_init],
                                                 params[:checkout_date_end]).page(params[:pages])
                 else
                   current_user.rentals.filter_by_checkout(
                     params[:checkout_date_init], params[:checkout_date_end]
                   ).page(params[:page])
                 end
    end
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

  def filtering_params(params)
    params.slice(:status, :checkout)
  end

  def base_index_filtering
    @rentals = current_user.admin? ? Rental.page(params[:page]) : current_user.rentals.page(params[:page])
  end
end
