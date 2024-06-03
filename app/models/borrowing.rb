class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user, :book, :borrowed_at, :due_at, presence: true

  after_create :decrease_book_copies
  after_update :increase_book_copies, if: :saved_change_to_returned?

  private

  def decrease_book_copies
    book.update(available_copies: book.available_copies - 1)
  end

  def increase_book_copies
    book.update(available_copies: book.available_copies + 1)
  end
end
