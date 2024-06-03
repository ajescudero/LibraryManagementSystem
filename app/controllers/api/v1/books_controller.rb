module Api
  module V1
    class BooksController < ApplicationController
      before_action :set_book, only: %i[show update destroy]
      before_action :authorize_librarian!, except: %i[index show]

      def index
        @books = Book.all
        render json: @books
      end

      def show
        render json: @book
      end

      def create
        @book = Book.new(book_params)
        if @book.save
          render json: @book, status: :created
        else
          render json: @book.errors, status: :unprocessable_entity
        end
      end

      def update
        if @book.update(book_params)
          render json: @book
        else
          render json: @book.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @book.destroy
        head :no_content
      end

      private

      def set_book
        @book = Book.find(params[:id])
      end

      def book_params
        params.require(:book).permit(:title, :author, :genre, :isbn, :total_copies, :available_copies)
      end

      def authorize_librarian!
        render json: { error: 'You are not authorized to perform this action.' }, status: :forbidden unless current_user.librarian?
      end
    end
  end
end
