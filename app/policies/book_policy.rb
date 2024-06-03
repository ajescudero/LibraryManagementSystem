# app/policies/book_policy.rb

class BookPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.librarian?
  end

  def update?
    user.librarian?
  end

  def destroy?
    user.librarian?
  end
end
