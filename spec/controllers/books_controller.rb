# spec/controllers/books_controller_spec.rb

require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:librarian) { create(:user, :librarian) }
  let(:book) { create(:book) }

  before do
    sign_in librarian
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      get :show, params: { id: book.id }
      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    it 'creates a new book' do
      expect do
        post :create, params: { book: attributes_for(:book) }
      end.to change(Book, :count).by(1)
    end
  end

  describe 'PUT #update' do
    it 'updates the book' do
      put :update, params: { id: book.id, book: { title: 'Updated Title' } }
      book.reload
      expect(book.title).to eq('Updated Title')
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the book' do
      book
      expect do
        delete :destroy, params: { id: book.id }
      end.to change(Book, :count).by(-1)
    end
  end
end
