# spec/factories/books.rb

FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    author { Faker::Book.author }
    genre { Faker::Book.genre }
    isbn { Faker::Code.isbn }
    total_copies { 5 }
    available_copies { 5 }
  end
end
