require 'rails_helper'

RSpec.describe Book, type: :model do
  it 'is valid with valid attributes' do
    book = build(:book)
    expect(book).to be_valid
  end

  it 'is not valid without a title' do
    book = build(:book, title: nil)
    expect(book).not_to be_valid
  end

  it 'is not valid without an author' do
    book = build(:book, author: nil)
    expect(book).not_to be_valid
  end

  it 'is not valid without an ISBN' do
    book = build(:book, isbn: nil)
    expect(book).not_to be_valid
  end

  it 'is not valid without a genre' do
    book = build(:book, genre: nil)
    expect(book).not_to be_valid
  end

  it 'is not valid without total copies' do
    book = build(:book, total_copies: nil)
    expect(book).not_to be_valid
  end

  it 'is not valid without available copies' do
    book = build(:book, available_copies: nil)
    expect(book).not_to be_valid
  end

  it 'is not valid if available copies are greater than total copies' do
    book = build(:book, total_copies: 5, available_copies: 6)
    expect(book).not_to be_valid
  end

  describe 'availability' do
    it 'is available for borrowing if available copies are greater than 0' do
      book = build(:book, available_copies: 1)
      expect(book.available_for_borrowing?).to be_truthy
    end

    it 'is not available for borrowing if available copies are 0' do
      book = build(:book, available_copies: 0)
      expect(book.available_for_borrowing?).to be_falsey
    end
  end
end
