class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :vendor, dependent: :destroy


  validates :name, presence: true
  validates :phone, presence: true

  enum :role, {
     customer: 0,
     admin: 1
  }

end
