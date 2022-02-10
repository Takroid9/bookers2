class BooksController < ApplicationController

  before_action :authenticate_user!

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id


    if @book.save

      redirect_to book_path(@book), notice: 'You have created book successfully.'
    else
      @books = Book.all
      @user = current_user

      render :index
    end
  end

  def index
    @books = Book.all
    @user = current_user
    @book = Book.new

  end

  def show
    @booker = Book.find(params[:id])
    @books = Book.all
    @user = @booker.user
    @book = Book.new
  end


  def edit
    @booker = Book.find(params[:id])
    if @booker.user != current_user
      redirect_to books_path
    end
  end

  def update
    @booker = Book.find(params[:id])
    if @booker.update(book_params)
      redirect_to book_path(@booker), notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end



  def destroy
    booker = Book.find(params[:id])
    booker.destroy
    redirect_to books_path
  end



  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def different_user
    unless user_signed_in? == current_user.id
      redirect_to edit_user_path(current_user.id)
    end
  end


end
