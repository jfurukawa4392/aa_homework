class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def new

  end

  def create
    if Book.create(book_params)
      redirect_to action: "index"
    else
      redirect_to action: :new
    end
  end

  def destroy
    book = Book.find_by_id(params[:id])
    book.delete

    redirect_to action: "index"
  end

  private
  def book_params
    params.require(:book).permit(:title, :author)
  end
end
