require "pry"

class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :only_admin, only: %i[new edit]

  def index
    @books = Book.page(params[:page])

    #Simplifying the many filter calls, its called on demand now

    filtering_params(params).each do |key, value|
      @books = @books.public_send("filter_by_#{key}", value) if value.present?
    end
  end

  def show
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to book_url(@book)
    else
      render :new, status: :unprocessable_entity
    end

  end

  def edit
  end

  def update

    if @book.update(book_params)
      redirect_to book_url(@book)
    else
      render :edit, status: :unprocessable_entity
    end

  end

  def destroy
    if @book.destroy and current_user.admin?
      redirect_to root_path
    else
      render :show, flash: {notice: "Server error: can't delete book"}
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:author, :title, :category, :check_out)
  end

  def only_admin
    redirect_to root_path unless current_user.admin?
  end

  def filtering_params(params)
    params.slice(:title,:author,:category,:status)
  end

end
