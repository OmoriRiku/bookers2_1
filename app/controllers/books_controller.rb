class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  #before_action :is_matching_book_user, only: [:edit]
  
  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book is created successfully"
      redirect_to book_path(@book.id)
    else
      @book = Book.new
      @books = Book.all
      @user = current_user
      render 'index'
    end
  end
  
  def show
    @new_book = Book.new
    @user = @book.user
  end
  
  def edit
  end
  
  def update
    if @book.update(book_params)
      flash[:notice] = "Book is update successfully"
      redirect_to book_path(@book)
    else
      render :edit
    end
  end
  
  def destroy
    @book.destroy
    redirect_to books_path
  end
  
  private
  
  def is_matching_book_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_back book_path(book)
    end
  end
  
  def set_book
    @book = Book.find(params[:id])
  end
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
