class RentalsController < ApplicationController
  before_action :set_rental, only: %i[show edit update destroy]
  before_action :book_checked_out, only: :create

  def index
    current_user.admin? ? @rentals = Rental.page(params[:page]) : @rentals = current_user.rentals.page(params[:page])

    #Simplifying the many filter calls, its called on demand now

    filtering_params(params).each do |key, value|
      @rentals = @rentals.public_send("filter_by_#{key}", value) if value.present?
    end
  end

  def show
  end

  def new
    @rental = Rental.new
  end

  def create

    @rental = Rental.new(rental_params)

    if @rental.save
      redirect_to rental_url(@rental)
    else
      redirect_to root_path
    end

  end

  def edit
  end

  def update
    @rental.finalize

    if @rental.save
      redirect_to rental_url(@rental)
    else
      redirect_to root_path
    end

  end

  def destroy
    if @rental.destroy
      redirect_to root_path
    end
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
    params.slice(:status,:checkout)
  end

end
