class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end
  
  def index
    @new_book = Book.new
    @books = Book.all
    @user = current_user
  end
  
  def show
    @new_book = Book.new
    @user = @book.user
  end
  
  def edit
  end
  
  def update
    @book.update(book_params)
    redirect_to book_path(@book)
  end
  
  def destroy
    @book.destroy
    redirect_to books_path
  end
  
  private
  
  def set_book
    @book = Book.find(params[:id])
  end
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
