module Api
  module V1
    class BorrowingsController < ApplicationController
      before_action :set_borrowing, only: %i[show update destroy]
      before_action :authorize_librarian!, only: %i[update destroy]

      def index
        @borrowings = current_user.borrowings
        render json: @borrowings
      end

      def show
        render json: @borrowing
      end

      def create
        @borrowing = current_user.borrowings.build(borrowing_params)
        @borrowing.borrowed_at = Time.current
        @borrowing.due_at = 2.weeks.from_now

        if @borrowing.save
          render json: @borrowing, status: :created
        else
          render json: @borrowing.errors, status: :unprocessable_entity
        end
      end

      def update
        if @borrowing.update(returned: true)
          render json: @borrowing
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

      def borrowing_params
        params.require(:borrowing).permit(:book_id)
      end

      def authorize_librarian!
        render json: { error: 'You are not authorized to perform this action.' }, status: :forbidden unless current_user.librarian?
      end
    end
  end
end
