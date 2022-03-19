class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end
  
  def edit
    @user = User.find(params[:id])
  if @user == current_user
    render "edit"
  else
  redirect_to user_path(current_user)
  end
end 
  
  def index
    @book = Book.all
    @new_book = Book.new
    @user = current_user
    @users = User.all
  end 

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if @user.save
    redirect_to user_path(@user), notice: "You have updated user successfully."
    else
    render :edit
    end 
  end
  

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
