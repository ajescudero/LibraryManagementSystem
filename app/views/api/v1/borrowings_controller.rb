# app/controllers/api/v1/borrowings_controller.rb

module Api
  module V1
    class BorrowingsController < ApplicationController
      before_action :authenticate_user!
      before_action :set_borrowing, only: %i[update destroy]

      def index
        @borrowings = Borrowing.all
        render json: @borrowings, status: :ok
      end

      def create
        book = Book.find(params[:book_id])
        if book.available_for_borrowing? && !current_user.borrowings.where(book:, returned: false).exists?
          @borrowing = current_user.borrowings.build(book:, borrowed_at: Time.current, due_at: 2.weeks.from_now,
                                                     returned: false)
          if @borrowing.save
            book.update(available_copies: book.available_copies - 1)
            render json: @borrowing, status: :created
          else
            render json: @borrowing.errors, status: :unprocessable_entity
          end
        else
          render json: { error: 'Book is not available for borrowing or you have already borrowed it.' },
                 status: :unprocessable_entity
        end
      end

      def update
        if @borrowing.update(returned: true)
          @borrowing.book.update(available_copies: @borrowing.book.available_copies + 1)
          render json: @borrowing, status: :ok
        else
          render json: @borrowing.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @borrowing.destroy
        head :no_content
      end

      private

      def set_borrowing
        @borrowing = Borrowing.find(params[:id])
      end
    end
  end
end
