# spec/factories/users.rb

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
    role { 'member' }

    trait :librarian do
      role { 'librarian' }
    end

    trait :member do
      role { 'member' }
    end
  end
end
