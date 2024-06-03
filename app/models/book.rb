class Book < ApplicationRecord
  validates :title, :author, :isbn, :genre, :total_copies, :available_copies, presence: true
  validates :total_copies, numericality: { greater_than_or_equal_to: 0 }
  validates :available_copies, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: :total_copies }, if: lambda {
                                                                                                                          total_copies.present?
                                                                                                                        }

  def available_for_borrowing?
    available_copies > 0
  end
end
