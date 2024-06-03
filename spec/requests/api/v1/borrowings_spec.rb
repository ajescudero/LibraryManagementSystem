# spec/requests/api/v1/borrowings_spec.rb

require 'rails_helper'

RSpec.describe 'Api::V1::Borrowings', type: :request do
  let(:user) { create(:user) }
  let(:librarian) { create(:user, :librarian) }
  let(:book) { create(:book) }
  let(:borrowing) { create(:borrowing, user:, book:) }

  before do
    sign_in user
  end

  describe 'GET /api/v1/borrowings' do
    it 'returns all borrowings' do
      get api_v1_borrowings_path
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(Borrowing.count)
    end
  end

  describe 'POST /api/v1/borrowings' do
    it 'creates a new borrowing' do
      post api_v1_borrowings_path, params: { book_id: book.id }
      expect(response).to have_http_status(:created)
      expect(user.borrowings.last.book).to eq(book)
    end
  end

  describe 'PATCH /api/v1/borrowings/:id' do
    before { sign_in librarian }

    it 'marks the borrowing as returned' do
      patch api_v1_borrowing_path(borrowing)
      expect(response).to have_http_status(:ok)
      expect(borrowing.reload.returned).to be_truthy
    end
  end

  describe 'DELETE /api/v1/borrowings/:id' do
    before { sign_in librarian }

    it 'deletes the borrowing' do
      delete api_v1_borrowing_path(borrowing)
      expect(response).to have_http_status(:no_content)
      expect(Borrowing.exists?(borrowing.id)).to be_falsey
    end
  end
end
