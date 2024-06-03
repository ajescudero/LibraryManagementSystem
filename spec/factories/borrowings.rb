# spec/factories/borrowings.rb

FactoryBot.define do
  factory :borrowing do
    association :user
    association :book
    borrowed_at { Time.current }
    due_at { 2.weeks.from_now }
    returned { false }
  end
end
