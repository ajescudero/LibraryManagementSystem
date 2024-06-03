require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  render_views # Agregar esta línea para permitir la renderización de vistas

  let(:librarian) { create(:user, :librarian) }
  let(:member) { create(:user, :member) }
  let(:book) { create(:book) }

  describe 'GET #index' do
    it 'returns a success response for authenticated user' do
      sign_in librarian
      get :index
      expect(response).to be_successful
    end

    it 'filters books by title' do
      sign_in librarian
      book1 = create(:book, title: 'Ruby on Rails')
      book2 = create(:book, title: 'Python Programming')
      get :index, params: { query: 'ruby', search_by: 'title' }
      expect(assigns(:books)).to include(book1)
      expect(assigns(:books)).not_to include(book2)
    end

    it 'filters books by author' do
      sign_in librarian
      book1 = create(:book, author: 'David Heinemeier Hansson')
      book2 = create(:book, author: 'Guido van Rossum')
      get :index, params: { query: 'david', search_by: 'author' }
      expect(assigns(:books)).to include(book1)
      expect(assigns(:books)).not_to include(book2)
    end

    it 'filters books by genre' do
      sign_in librarian
      book1 = create(:book, genre: 'Technology')
      book2 = create(:book, genre: 'Science Fiction')
      get :index, params: { query: 'technology', search_by: 'genre' }
      expect(assigns(:books)).to include(book1)
      expect(assigns(:books)).not_to include(book2)
    end

    it 'redirects to sign in if user is not authenticated' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      sign_in librarian
      get :show, params: { id: book.id }
      expect(response).to be_successful
    end

    it 'redirects to sign in if user is not authenticated' do
      get :show, params: { id: book.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET #new' do
    it 'returns a success response for librarian' do
      sign_in librarian
      get :new
      expect(response).to be_successful
    end

    it 'redirects member to root path' do
      sign_in member
      get :new
      expect(response).to redirect_to(root_path)
    end

    it 'redirects to sign in if user is not authenticated' do
      get :new
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'GET #edit' do
    it 'returns a success response for librarian' do
      sign_in librarian
      get :edit, params: { id: book.id }
      expect(response).to be_successful
    end

    it 'redirects member to root path' do
      sign_in member
      get :edit, params: { id: book.id }
      expect(response).to redirect_to(root_path)
    end

    it 'redirects to sign in if user is not authenticated' do
      get :edit, params: { id: book.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { attributes_for(:book) }
    let(:invalid_attributes) { { title: nil } }

    context 'as a librarian' do
      before { sign_in librarian }

      it 'creates a new book with valid attributes' do
        expect do
          post :create, params: { book: valid_attributes }
        end.to change(Book, :count).by(1)
        expect(response).to redirect_to(Book.last)
      end

      it 'does not create a new book with invalid attributes' do
        expect do
          post :create, params: { book: invalid_attributes }
        end.not_to change(Book, :count)
        expect(response).to render_template(:new)
      end
    end

    context 'as a member' do
      before { sign_in member }

      it 'does not allow to create a new book' do
        post :create, params: { book: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    it 'redirects to sign in if user is not authenticated' do
      post :create, params: { book: valid_attributes }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'PUT #update' do
    let(:new_attributes) { { title: 'Updated Title' } }

    context 'as a librarian' do
      before { sign_in librarian }

      it 'updates the book with valid attributes' do
        put :update, params: { id: book.id, book: new_attributes }
        book.reload
        expect(book.title).to eq('Updated Title')
        expect(response).to redirect_to(book)
      end

      it 'does not update the book with invalid attributes' do
        put :update, params: { id: book.id, book: { title: nil } }
        book.reload
        expect(book.title).not_to be_nil
        expect(response).to render_template(:edit)
      end
    end

    context 'as a member' do
      before { sign_in member }

      it 'does not allow to update the book' do
        put :update, params: { id: book.id, book: new_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    it 'redirects to sign in if user is not authenticated' do
      put :update, params: { id: book.id, book: new_attributes }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'DELETE #destroy' do
    context 'as a librarian' do
      before { sign_in librarian }

      it 'deletes the book' do
        book
        expect do
          delete :destroy, params: { id: book.id }
        end.to change(Book, :count).by(-1)
        expect(response).to redirect_to(books_url)
      end
    end

    context 'as a member' do
      before { sign_in member }

      it 'does not allow to delete the book' do
        delete :destroy, params: { id: book.id }
        expect(response).to redirect_to(root_path)
      end
    end

    it 'redirects to sign in if user is not authenticated' do
      delete :destroy, params: { id: book.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
