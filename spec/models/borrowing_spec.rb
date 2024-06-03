require 'rails_helper'

RSpec.describe Borrowing, type: :model do
  let(:user) { create(:user) }
  let(:book) { create(:book) }

  it 'is valid with valid attributes' do
    borrowing = build(:borrowing, user:, book:)
    expect(borrowing).to be_valid
  end

  it 'is not valid without a user' do
    borrowing = build(:borrowing, user: nil, book:)
    expect(borrowing).not_to be_valid
  end

  it 'is not valid without a book' do
    borrowing = build(:borrowing, user:, book: nil)
    expect(borrowing).not_to be_valid
  end

  it 'is not valid without a borrowed_at date' do
    borrowing = build(:borrowing, user:, book:, borrowed_at: nil)
    expect(borrowing).not_to be_valid
  end

  it 'is not valid without a due_at date' do
    borrowing = build(:borrowing, user:, book:, due_at: nil)
    expect(borrowing).not_to be_valid
  end

  describe 'borrow and return' do
    it 'is not returned when created' do
      borrowing = create(:borrowing, user:, book:, returned: false)
      expect(borrowing.returned).to be_falsey
    end

    it 'can be marked as returned' do
      borrowing = create(:borrowing, user:, book:, returned: false)
      borrowing.update(returned: true)
      expect(borrowing.returned).to be_truthy
    end

    it 'decreases available copies of the book when borrowed' do
      expect do
        create(:borrowing, user:, book:)
      end.to change { book.reload.available_copies }.by(-1)
    end

    it 'increases available copies of the book when returned' do
      borrowing = create(:borrowing, user:, book:, returned: false)
      expect do
        borrowing.update(returned: true)
        book.reload
      end.to change { book.available_copies }.by(1)
    end
  end
end
