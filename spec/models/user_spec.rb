require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    user = build(:user)
    expect(user).to be_valid
  end

  it 'is not valid without an email' do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it 'is not valid without a password' do
    user = build(:user, password: nil)
    expect(user).not_to be_valid
  end

  it 'is not valid with a short password' do
    user = build(:user, password: 'short')
    expect(user).not_to be_valid
  end

  it 'is not valid with a duplicate email address' do
    create(:user, email: 'test@example.com')
    user = build(:user, email: 'test@example.com')
    expect(user).not_to be_valid
  end

  it 'is valid with a password of valid length' do
    user = build(:user, password: 'password')
    expect(user).to be_valid
  end

  describe 'roles' do
    it 'has a default role of member' do
      user = create(:user)
      expect(user.role).to eq('member')
    end

    it 'can be created as a librarian' do
      user = create(:user, :librarian)
      expect(user.role).to eq('librarian')
    end
  end

  describe 'associations' do
    it 'has many borrowings' do
      user = create(:user)
      borrowing1 = create(:borrowing, user:)
      borrowing2 = create(:borrowing, user:)
      expect(user.borrowings).to include(borrowing1, borrowing2)
    end
  end
end
