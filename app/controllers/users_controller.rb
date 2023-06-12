class UsersController < ApplicationController
  
  before_action :set_user, only: [:show, :edit, :update]
  
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end
  
  def show
    @book = Book.new
    @books = @user.books.all
  end
  
  def edit
  end
  
  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
end
