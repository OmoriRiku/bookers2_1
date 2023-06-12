class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit]
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
    if @user.update(user_params)
      flash[:notice] = "User is update successfully"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  private
  
  def is_matching_login_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id
      redirect_to user_path(@user)
    end
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
end
