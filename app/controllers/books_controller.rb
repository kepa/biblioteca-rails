class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]
  before_action :only_admin, only: %i[new edit]

  def index
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
      flash[:notice] = "Invalid book creation"
      render :new
    end

  end

  def edit
  end

  def update

    if @book.update(book_params)
      redirect_to book_url(@book)
    else
      render :edit
    end

  end

  def destroy
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

end
