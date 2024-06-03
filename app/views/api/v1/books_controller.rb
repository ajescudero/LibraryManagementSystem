# app/controllers/api/v1/books_controller.rb

module Api
  module V1
    class BooksController < ApplicationController
      before_action :authenticate_user!
      before_action :set_book, only: %i[show update destroy]

      def index
        @books = Book.all
        render json: @books, status: :ok
      end

      def show
        render json: @book, status: :ok
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
          render json: @book, status: :ok
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
    end
  end
end
