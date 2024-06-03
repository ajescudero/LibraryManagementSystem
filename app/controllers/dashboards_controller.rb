# app/controllers/dashboards_controller.rb

class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    if current_user.librarian?
      @total_books = Book.count
      @total_borrowed_books = Borrowing.where(returned: false).count
      @books_due_today = Borrowing.where(due_at: Date.today, returned: false)
      @borrowed_books = Borrowing.where(returned: false)
      @overdue_members = User.joins(:borrowings)
                             .where(borrowings: { returned: false })
                             .where('borrowings.due_at < ?', Date.today)
                             .distinct
    else
      @borrowings = current_user.borrowings
      @overdue_books = @borrowings.where('due_at < ?', Date.today).where(returned: false)
    end
  end
end
