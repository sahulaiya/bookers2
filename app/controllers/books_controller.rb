class BooksController < ApplicationController
  def new
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book), notice: "You have updated user successfully."
    else
    @books = Book.all
    @user = current_user
    render :index
    end 
  end
  
  def edit
   @book = Book.find(params[:id])
  if @book.user == current_user
    render "edit"
  else
  redirect_to books_path
  end
  end
  
  def update
    @book = Book.find(params[:id])
    @book.update(book_params)
    if @book.save
    redirect_to book_path(@book[:id]), notice: "You have updated book successfully."
    else
    @books = Book.all
    @user = current_user
    render :edit
    end 
  end 

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end
  
  

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  private
  def book_params
    params.require(:book).permit(:title,:body).merge(user_id: current_user.id)
  end
  
end
