# app/controllers/books_controller.rb

class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_book, only: %i[show edit update destroy]
  before_action :authorize_librarian!, except: %i[index show]

  def index
    @books = policy_scope(Book)
    return unless params[:query].present?

    @books = @books.where('LOWER(title) LIKE ? OR LOWER(author) LIKE ? OR LOWER(genre) LIKE ?',
                          "%#{params[:query].downcase}%", "%#{params[:query].downcase}%", "%#{params[:query].downcase}%")
  end

  def show
    authorize @book
  end

  def new
    @book = Book.new
    authorize @book
  end

  def edit
    authorize @book
  end

  def create
    @book = Book.new(book_params)
    authorize @book
    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def update
    authorize @book
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @book
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :genre, :isbn, :total_copies, :available_copies)
  end

  def authorize_librarian!
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.librarian?
  end
end
