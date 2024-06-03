# app/controllers/application_controller.rb
# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # Ensure Pundit is used to handle authorization exceptions
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end
end
