FactoryBot.define do
  factory :borrowing do
    user { nil }
    book { nil }
    borrowed_at { "2024-06-02 21:43:42" }
    due_at { "2024-06-02 21:43:42" }
    returned { false }
  end
end
