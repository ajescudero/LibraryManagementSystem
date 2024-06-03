# spec/requests/api/v1/books_spec.rb

require 'rails_helper'

RSpec.describe 'Api::V1::Books', type: :request do
  let(:librarian) { create(:user, :librarian) }
  let(:book) { create(:book) }

  before do
    sign_in librarian
  end

  describe 'GET /api/v1/books' do
    it 'returns all books' do
      get api_v1_books_path
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(Book.count)
    end
  end

  describe 'GET /api/v1/books/:id' do
    it 'returns the book' do
      get api_v1_book_path(book)
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(book.id)
    end
  end

  describe 'POST /api/v1/books' do
    it 'creates a new book' do
      book_params = attributes_for(:book)
      post api_v1_books_path, params: { book: book_params }
      expect(response).to have_http_status(:created)
      expect(Book.last.title).to eq(book_params[:title])
    end
  end

  describe 'PUT /api/v1/books/:id' do
    it 'updates the book' do
      book_params = { title: 'Updated Title' }
      put api_v1_book_path(book), params: { book: book_params }
      expect(response).to have_http_status(:ok)
      expect(book.reload.title).to eq('Updated Title')
    end
  end

  describe 'DELETE /api/v1/books/:id' do
    it 'deletes the book' do
      delete api_v1_book_path(book)
      expect(response).to have_http_status(:no_content)
      expect(Book.exists?(book.id)).to be_falsey
    end
  end
end
