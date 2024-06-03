# app/controllers/borrowings_controller.rb

class BorrowingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_borrowing, only: %i[update destroy]
  before_action :authorize_librarian!, only: %i[update destroy]

  def index
    @borrowings = current_user.borrowings
  end

  def create
    book = Book.find(params[:book_id])
    if book.available_for_borrowing? && !current_user.borrowings.where(book:, returned: false).exists?
      @borrowing = current_user.borrowings.build(book:, borrowed_at: Time.current, due_at: 2.weeks.from_now,
                                                 returned: false)
      if @borrowing.save
        book.update(available_copies: book.available_copies - 1)
        redirect_to borrowings_path, notice: 'Book was successfully borrowed.'
      else
        redirect_to books_path, alert: 'Could not borrow the book.'
      end
    else
      redirect_to books_path, alert: 'Book is not available for borrowing or you have already borrowed it.'
    end
  end

  def update
    if @borrowing.update(returned: true)
      @borrowing.book.update(available_copies: @borrowing.book.available_copies + 1)
      redirect_to borrowings_path, notice: 'Book was successfully returned.'
    else
      render :edit
    end
  end

  def destroy
    @borrowing.destroy
    redirect_to borrowings_url, notice: 'Borrowing was successfully destroyed.'
  end

  private

  def set_borrowing
    @borrowing = Borrowing.find(params[:id])
  end

  def authorize_librarian!
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.librarian?
  end
end
