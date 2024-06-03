class Book < ApplicationRecord
  has_many :borrowings
  has_many :users, through: :borrowings

  validates :title, :author, :genre, :isbn, :total_copies, :available_copies, presence: true

  def available_for_borrowing?
    available_copies.positive?
  end
end
