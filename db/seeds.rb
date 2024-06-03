User.create!(email: 'librarian@example.com', password: 'password', password_confirmation: 'password', role: :librarian)
User.create!(email: 'member@example.com', password: 'password', password_confirmation: 'password', role: :member)

20.times do
  Book.create!(
    title: Faker::Book.title,
    author: Faker::Book.author,
    genre: Faker::Book.genre,
    isbn: Faker::Number.number(digits: 10),
    total_copies: rand(1..10),
    available_copies: rand(1..10)
  )
end
