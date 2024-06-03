class BorrowingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_borrowing, only: %i[show update destroy]
  before_action :authorize_librarian!, only: %i[update destroy]

  def index
    @borrowings = current_user.borrowings
  end

  def create
    @borrowing = current_user.borrowings.build(borrowing_params)
    @borrowing.borrowed_at = Time.current
    @borrowing.due_at = 2.weeks.from_now

    if @borrowing.save
      redirect_to @borrowing, notice: 'Book was successfully borrowed.'
    else
      render :new
    end
  end

  def update
    if @borrowing.update(returned: true)
      redirect_to @borrowing, notice: 'Book was successfully returned.'
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

  def borrowing_params
    params.require(:borrowing).permit(:book_id)
  end

  def authorize_librarian!
    redirect_to root_path, alert: 'You are not authorized to perform this action.' unless current_user.librarian?
  end
end
