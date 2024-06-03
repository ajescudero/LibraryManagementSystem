class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :borrowings

  enum role: { member: 0, librarian: 1 }

  after_initialize do
    if self.new_record?
      self.role ||= :member
    end
  end
end
